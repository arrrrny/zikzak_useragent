## 1.1.1
 - Fixed default value
 
## 1.1.0

### 🔥 ZIKZAK iOS IMPLEMENTATION REFACTOR 🔥

**BREAKING CHANGES:**
- **PACKAGE RENAME**: `webview_useragent_ios` → `zikzak_useragent_ios`
- **CLASS RENAME**: `WebviewUserAgentPlugin` → `ZikzakUserAgentPlugin`
- **METHOD CHANNEL**: Updated from `webview_useragent` to `zikzak_useragent`
- **IMPORT PATHS**: Updated platform interface import to `zikzak_useragent_platform_interface`
- **DART CLASS**: `WebviewUserAgentIOS` → `ZikzakUserAgentIOS`

**iOS-SPECIFIC IMPROVEMENTS:**
- ✅ Enhanced WKWebView JavaScript evaluation with better error handling
- ✅ Safari/604.1 suffix automatic appending for web compatibility
- ✅ Improved Swift code formatting and documentation
- ✅ Memory-efficient WKWebView initialization
- ✅ Thread-safe async result handling

**TECHNICAL UPDATES:**
- **Swift Version**: 5.0 (maintained)
- **iOS Deployment Target**: 12.0+ (maintained)
- **Podspec**: Updated to `zikzak_useragent_ios.podspec`
- **License**: Apache License 2.0
- **Architecture**: Clean Architecture compliance

**PERFORMANCE ENHANCEMENTS:**
- **Lazy Loading**: WKWebView created only when needed
- **Async Optimization**: Non-blocking JavaScript evaluation
- **Memory Footprint**: Minimal resource usage
- **Error Recovery**: Graceful handling of JavaScript failures

**MIGRATION GUIDE:**
```swift
// OLD (v1.0.0)
class WebviewUserAgentPlugin: NSObject, FlutterPlugin {
    let channel = FlutterMethodChannel(name: "webview_useragent", ...)
}

// NEW (v1.1.0)
class ZikzakUserAgentPlugin: NSObject, FlutterPlugin {
    let channel = FlutterMethodChannel(name: "zikzak_useragent", ...)
}
```

```dart
// OLD Dart Implementation
import 'package:webview_useragent_platform_interface/webview_useragent_platform_interface.dart';
class WebviewUserAgentIOS extends WebviewUserAgentPlatform { }

// NEW Dart Implementation
import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';
class ZikzakUserAgentIOS extends ZikzakUserAgentPlatform { }
```

**TESTING UPDATES:**
- ✅ Updated unit tests to use `ZikzakUserAgentPlugin`
- ✅ Enhanced test coverage for error scenarios
- ✅ Improved XCTest integration

**PODSPEC CHANGES:**
- **Name**: `zikzak_useragent_ios`
- **Author**: ARRRRNY
- **Homepage**: https://github.com/arrrrny/zikzak_useragent
- **License**: Apache License 2.0 (no longer file-based)

**AUTHOR**: ARRRRNY  
**WEBSITE**: zuzu.dev  
**EMAIL**: arrrrny@zuzu.dev  

---

**Native iOS precision. WKWebView mastery. Zero compromise.**

## 1.0.0

* Initial release.
