//
//  API.swift
//  ApiTapiPurchases
//
//  Created by Appbooster on 02/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import Foundation

enum PurchasesError: Error {
  
  case invalidResponse
  case serverError(statusCode: Int)

  var description: String {
    switch self {
    case .invalidResponse: return "Invalid response from server"
    case .serverError(let statusCode): return "Server error, status code: \(statusCode)"
    }
  }

}

struct API {

  static let modifier: String = "api"
  static let versionModifier: String = "v"
  static let version: Int = 1
  static let path: String = "app_webhooks"

  static func post(_ url: URL,
                   headers: [String: String]?,
                   body: Data?,
                   completion: @escaping (_ error: Error?) -> Void) {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.allHTTPHeaderFields = headers
    urlRequest.httpBody = body

    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        DispatchQueue.main.async {
          completion(error)
        }

        return
      }

      guard let response = response as? HTTPURLResponse else {
        DispatchQueue.main.async {
          completion(PurchasesError.invalidResponse)
        }
        
        return
      }
      
      guard 200 ..< 300 ~= response.statusCode else {
        DispatchQueue.main.async {
          completion(PurchasesError.serverError(statusCode: response.statusCode))
        }
        
        return
      }
      
      DispatchQueue.main.async {
        completion(nil)
      }
      }.resume()
  }

}
