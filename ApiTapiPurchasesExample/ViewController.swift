//
//  ViewController.swift
//  ApiTapiPurchasesExample
//
//  Created by Appbooster on 02/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let purchases = ApiTapiPurchases(authToken: "<APITAPI_AUTH_TOKEN>",
                                     deviceToken: "<DEVICE_TOKEN")
    purchases.track(productId: "<PRODUCT_ID>", // SKProduct productIdentifier
                    revenue: 99.0, // SKProduct price.doubleValue
                    currency: "USD", // SKProduct priceLocale.currencyCode
                    completion: { error in })
  }

}

