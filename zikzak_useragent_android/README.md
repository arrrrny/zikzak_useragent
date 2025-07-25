# 🔥 ZikZak UserAgent Android 🔥

**Native Android UserAgent Extraction with WebView Precision**

The Android implementation of `zikzak_useragent` that leverages Android WebView to extract authentic Chrome/WebView UserAgent strings with surgical precision.

## **WHAT IT DOES**

This package provides the Android-specific implementation for extracting native UserAgent strings using Android WebView's settings. No compromises. No "good enough" solutions.

## **TECHNICAL IMPLEMENTATION**

### **Kotlin Implementation**
- **WebView Integration**: Direct access to `webView.settings.userAgentString`
- **Async Result Handling**: Flutter-compliant async result callbacks
- **Memory Efficient**: Lazy WebView initialization
- **Context Aware**: Application context-based WebView creation

### **UserAgent Format**
```
Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36
```

### **Architecture**
```
Flutter Dart Layer
       ↓
Method Channel (zikzak_useragent)
       ↓
ZikzakUserAgentPlugin.kt
       ↓
WebView.settings.userAgentString
       ↓
Native Android UserAgent
```

## **REQUIREMENTS**

- **Android**: API Level 19+ (Android 4.4)
- **Kotlin**: Latest stable
- **Android SDK**: 33+
- **Flutter**: >=3.19.0

## **INTEGRATION**

This package is automatically included when you add `zikzak_useragent` to your `pubspec.yaml`. The Android implementation registers itself automatically:

```dart
// Automatic registration
ZikzakUserAgentPlatform.instance = ZikzakUserAgentAndroid();
```

## **METHOD CHANNEL**

- **Channel Name**: `zikzak_useragent`
- **Method**: `getPlatformUserAgent`
- **Return Type**: `String`

## **KOTLIN PLUGIN DETAILS**

### **Class**: `ZikzakUserAgentPlugin`
- Implements: `FlutterPlugin, MethodCallHandler`
- **Registration**: onAttachedToEngine with FlutterPluginBinding
- **WebView**: Instance variable for UserAgent extraction
- **Method Handling**: Switch-based method call routing

### **WebView UserAgent Extraction**
```kotlin
override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformUserAgent") {
        val userAgent = webView?.settings?.userAgentString
        result.success(userAgent)
    } else {
        result.notImplemented()
    }
}
```

## **WEBVIEW INITIALIZATION**

```kotlin
override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zikzak_useragent")
    channel.setMethodCallHandler(this)
    webView = WebView(flutterPluginBinding.applicationContext)
}
```

## **ERROR HANDLING**

- **Null Safety**: Safe handling of potential null WebView
- **Context Errors**: Application context ensures proper WebView creation
- **Method Errors**: `result.notImplemented()` for unknown methods
- **Memory Management**: Proper cleanup in `onDetachedFromEngine`

## **PERFORMANCE**

- **Lazy Initialization**: WebView created only when needed
- **Memory Efficient**: Minimal footprint implementation
- **Context Optimized**: Application context for lifecycle management
- **Thread Safe**: Flutter-compliant async patterns

## **PACKAGE STRUCTURE**

```
android/
├── src/main/kotlin/com/strysk/zikzak_useragent_android/zikzak_useragent_android/
│   └── ZikzakUserAgentPlugin.kt
lib/
└── zikzak_useragent_android.dart
```

## **PERMISSIONS**

No special Android permissions required. WebView UserAgent is accessible without additional permissions.

## **TESTING**

Android implementation testing via Flutter integration tests:

```dart
testWidgets('getPlatformUserAgent test', (WidgetTester tester) async {
  final ZikzakUserAgent plugin = ZikzakUserAgent();
  final String? userAgent = await plugin.getPlatformUserAgent();
  expect(userAgent?.isNotEmpty, true);
});
```

## **GRADLE CONFIGURATION**

Standard Flutter plugin configuration - no additional Gradle setup required.

## **COMPATIBILITY**

- **Android Versions**: 4.4+ (API 19+)
- **WebView**: System WebView and Chrome Custom Tabs
- **Architecture**: ARM, ARM64, x86, x86_64
- **Flutter Versions**: 3.19.0+

## **CHANGELOG**

### v1.1.0 - ZIKZAK Refactor
- ✅ Rebranded from `webview_useragent_android`
- ✅ Updated class names: `WebviewUserAgentPlugin` → `ZikzakUserAgentPlugin`
- ✅ Enhanced method channel naming
- ✅ Improved Kotlin code structure
- ✅ Package path reorganization

## **LICENSE**

Apache License 2.0

## **CREDITS**

**Built by ARRRRNY** for the ZIKZAK ecosystem.

- **Website**: [zuzu.dev](https://zuzu.dev)
- **Email**: arrrrny@zuzu.dev
- **Repository**: [github.com/arrrrny/zikzak_useragent](https://github.com/arrrrny/zikzak_useragent)

---

**Native Android precision. WebView mastery. Zero compromise.**

**WE ARE ZIKZAK.**