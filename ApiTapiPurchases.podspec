#
# Be sure to run `pod lib lint ApiTapiPurchases.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ApiTapiPurchases'
  s.version          = '1.0.0'
  s.summary          = 'Purchases framework for apitapi service.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'The framework that helps to send info about purchases to ApiTapi service.'

  s.homepage         = 'https://github.com/appbooster/apitapi-purchases-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vladimir Vasilev' => 'fredformout@yandex.ru' }
  s.source           = { :git => 'https://github.com/appbooster/apitapi-purchases-ios.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ApiTapiPurchases/Classes/*', 'ApiTapiPurchases/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ApiTapiPurchases' => ['ApiTapiPurchases/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.swift_version = "5.0"
  
end
