//
//  ApiTapiPurchase.swift
//  ApiTapiPurchases
//
//  Created by Appbooster on 03/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import Foundation

struct ApiTapiPurchase: Codable {

  let productId: String
  let revenue: String
  let currency: String?
  let receipt: String?
  let idfa: String?
  let idfv: String?
  let analyticsIdentifiers: [String: String]?

  enum CodingKeys: String, CodingKey {
    case productId = "product_id"
    case revenue
    case currency
    case receipt
    case idfa
    case idfv
    case analyticsIdentifiers = "analytics_identifiers"
  }

}
