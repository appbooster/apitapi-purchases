//
//  ApiTapiPurchases.swift
//  ApiTapiPurchases
//
//  Created by Appbooster on 02/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import UIKit
import AdSupport

private let defaultServerUrl: String = "https://new.apitapi.com"

public final class ApiTapiPurchases: NSObject {

  private let serverUrl: String
  private let authToken: String
  private let deviceToken: String

  public init(serverUrl: String? = nil, authToken: String, deviceToken: String) {
    self.serverUrl = serverUrl ?? defaultServerUrl
    self.authToken = authToken
    self.deviceToken = deviceToken

    super.init()
  }

  public var showDebug: Bool = false
  public var log: ((String) -> Void)?

  public var lastOperationDuration: TimeInterval = 0.0

  public func track(productId: String,
                    revenue: Double,
                    currency: String?,
                    receipt: String? = nil,
                    analyticsIdentifiers: [String: String]? = nil,
                    completion: @escaping (_ error: String?) -> Void) {
    let urlPath = [serverUrl, API.modifier, "\(API.versionModifier)\(API.version)", API.path]
      .joined(separator: "/")

    guard let url = URL(string: urlPath) else {
      let error = "Invalid url"

      debugAndLog("[ApiTapiPurchases] \(error)")

      completion(error)

      return
    }

    let purchase = makePurchase(productId: productId,
                                revenue: revenue,
                                currency: currency,
                                receipt: receipt,
                                analyticsIdentifiers: analyticsIdentifiers)

    do {
      let body = try JSONEncoder().encode(purchase)
      let headers = [
        "Content-Type": "application/json",
        "Authorization": authToken,
        "DeviceToken": deviceToken,
        "AppVersion": Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
      ]

      let startDate = Date()

      API.post(url,
               headers: headers,
               body: body,
               completion: { [weak self] error in
                guard let self = self else { return }

                self.lastOperationDuration = Date().timeIntervalSince(startDate)

                var resultError: String?

                if let error = error {
                  if let purchasesError = error as? PurchasesError {
                    resultError = purchasesError.description
                  } else {
                    resultError = "Error: \(error.localizedDescription)"
                  }
                }

                resultError.map({ self.debugAndLog("[ApiTapiPurchases] \($0)") })

                completion(resultError)
      })
    } catch {
      debugAndLog("[ApiTapiPurchases] Purchase encoding error: \(error.localizedDescription)")
    }
  }

  // MARK: Others

  private func makePurchase(productId: String,
                            revenue: Double,
                            currency: String?,
                            receipt: String?,
                            analyticsIdentifiers: [String: String]? = nil) -> ApiTapiPurchase {
    if currency == nil {
      debugAndLog("[ApiTapiPurchases] Currency is empty")
    }

    var idfa: String?

    if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
      idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    } else {
      debugAndLog("[ApiTapiPurchases] Advertising tracking is disabled")
    }

    var idfv: String?

    if let identifierForVendor = UIDevice.current.identifierForVendor?.uuidString {
      idfv = identifierForVendor
    } else {
      debugAndLog("[ApiTapiPurchases] Can't get the identifier for vendor")
    }

    var receipt = receipt

    if receipt == nil {
      debugAndLog("[ApiTapiPurchases] Trying to retrieve the receipt from appStoreReceiptURL...")

      if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
        FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
        do {
          let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
          receipt = receiptData.base64EncodedString(options: [])
        } catch {
          debugAndLog("[ApiTapiPurchases] Can't retrieve the receipt from appStoreReceiptURL")
        }
      } else {
        debugAndLog("[ApiTapiPurchases] There is no receipt at appStoreReceiptURL")
      }
    }

    let purchase = ApiTapiPurchase(productId: productId,
                                   revenue: "\(revenue)",
                                   currency: currency,
                                   receipt: receipt,
                                   idfa: idfa,
                                   idfv: idfv,
                                   analyticsIdentifiers: analyticsIdentifiers)

    return purchase
  }

  // MARK: Service

  private func debugAndLog(_ text: String) {
    if showDebug {
      #if DEBUG
      print(text)
      #endif
    }

    log?(text)
  }

}
