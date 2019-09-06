# apitapi-purchases-ios

Framework for purchase tracking.

## Installation

CocoaPods:

```
pod 'ApiTapiPurchases'
```

## Usage

```
import ApiTapiPurchases
```

### Initialization:

```
let purchases = ApiTapiPurchases(serverUrl: "<YOUR_APITAPI_SERVER_URL>", // optional, e.g. "https://new.apitapi.com"
                                 authToken: "<YOUR_APITAPI_AUTH_TOKEN>",
                                 deviceToken: "<YOUR_DEVICE_TOKEN")
```

### How to track the purchase?

```
purchases.track(productId: "<YOUR_PRODUCT_IDENTIFIER>", // SKProduct productIdentifier
                revenue: 99.0, // SKProduct price.doubleValue
                currency: "USD", // SKProduct priceLocale.currencyCode
                receipt: "<YOUR_RECEIPT_AS_BASE64_STRING>", // optional, the receipt as base64 string, it will take Bundle.main.appStoreReceiptURL content if parameter is not provided
                analyticsIdentifiers: [:], // optional, the dictionary of specific analytics identifiers e.g. ["appMetrica": "<YOUR_APP_METRICA_IDENTIFIER>"], WIP feature
                completion: { error in })
```

### How to debug?

```
purchases.showDebug = true // false by default, to print all debugging info in the console
purchases.log = { text in } // to define your own log handler
let duration = purchases.lastOperationDuration // the duration of the last operation in seconds
```

==================================================

You can see the example of usage in the attached project.
