# 🔥 ZikZak UserAgent iOS 🔥

**Native iOS UserAgent Extraction with WKWebView Precision**

The iOS implementation of `zikzak_useragent` that leverages WKWebView to extract authentic Safari UserAgent strings with surgical precision.

## **WHAT IT DOES**

This package provides the iOS-specific implementation for extracting native UserAgent strings using WKWebView's JavaScript evaluation capabilities. No compromises. No "good enough" solutions.

## **TECHNICAL IMPLEMENTATION**

### **Swift Implementation**
- **WKWebView Integration**: Direct JavaScript evaluation of `navigator.userAgent`
- **Async Result Handling**: Flutter-compliant async result callbacks
- **Memory Efficient**: Lazy WKWebView initialization
- **Error Resilient**: Graceful handling of JavaScript evaluation failures

### **UserAgent Format**
```
Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari/604.1
```

### **Architecture**
```
Flutter Dart Layer
       ↓
Method Channel (zikzak_useragent)
       ↓
ZikzakUserAgentPlugin.swift
       ↓
WKWebView.evaluateJavaScript
       ↓
Native iOS UserAgent
```

## **REQUIREMENTS**

- **iOS**: 12.0+
- **Swift**: 5.0+
- **Xcode**: 12.0+
- **Flutter**: >=3.19.0

## **INTEGRATION**

This package is automatically included when you add `zikzak_useragent` to your `pubspec.yaml`. The iOS implementation registers itself automatically:

```dart
// Automatic registration
ZikzakUserAgentPlatform.instance = ZikzakUserAgentIOS();
```

## **METHOD CHANNEL**

- **Channel Name**: `zikzak_useragent`
- **Method**: `getPlatformUserAgent`
- **Return Type**: `String`

## **SWIFT PLUGIN DETAILS**

### **Class**: `ZikzakUserAgentPlugin`
- Extends: `NSObject, FlutterPlugin`
- **Registration**: Static method with FlutterPluginRegistrar
- **WKWebView**: Instance variable for JavaScript evaluation
- **Method Handling**: Switch-based method call routing

### **JavaScript Evaluation**
```swift
webView.evaluateJavaScript("navigator.userAgent;") { (result, error) in
    guard let userAgent = result as? String else { return }
    result(userAgent)
}
```

## **SAFARI SUFFIX**

The Dart layer automatically appends ` Safari/604.1` to maintain compatibility with Safari-specific web detection:

```dart
String userAgent = await methodChannel.invokeMethod("getPlatformUserAgent");
return userAgent += ' Safari/604.1';
```

## **ERROR HANDLING**

- **JavaScript Errors**: Handled by WKWebView completion handler
- **Type Safety**: Guard statements ensure String type casting
- **Method Errors**: FlutterMethodNotImplemented for unknown methods

## **PERFORMANCE**

- **Lazy Initialization**: WKWebView created only when needed
- **Memory Efficient**: Minimal footprint implementation
- **Async Optimized**: Non-blocking JavaScript evaluation
- **Thread Safe**: Flutter-compliant async patterns

## **TESTING**

iOS unit tests verify UserAgent extraction:

```swift
func testGetPlatformUserAgent() {
    let plugin = ZikzakUserAgentPlugin()
    let call = FlutterMethodCall(methodName: "getPlatformUserAgent", arguments: [])
    
    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
        XCTAssertEqual(result as! String, "iOS " + UIDevice.current.systemVersion)
        resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
}
```

## **PODSPEC CONFIGURATION**

- **Name**: `zikzak_useragent_ios`
- **Version**: 1.1.0
- **License**: Apache License 2.0
- **Platform**: iOS 12.0+
- **Swift Version**: 5.0

## **CHANGELOG**

### v1.1.0 - ZIKZAK Refactor
- ✅ Rebranded from `webview_useragent_ios`
- ✅ Updated class names: `WebviewUserAgentPlugin` → `ZikzakUserAgentPlugin`
- ✅ Enhanced method channel naming
- ✅ Improved Swift code formatting
- ✅ Safari suffix integration

## **LICENSE**

Apache License 2.0

## **CREDITS**

**Built by ARRRRNY** for the ZIKZAK ecosystem.

- **Website**: [zuzu.dev](https://zuzu.dev)
- **Email**: arrrrny@zuzu.dev
- **Repository**: [github.com/arrrrny/zikzak_useragent](https://github.com/arrrrny/zikzak_useragent)

---

**Native iOS precision. Zero compromise. Maximum efficiency.**

**WE ARE ZIKZAK.**