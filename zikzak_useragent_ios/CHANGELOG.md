## 1.1.5 - 2026-06-14


- Fix Swift 6 concurrency errors on iOS and macOS plugins
- Add `@preconcurrency import` for Flutter frameworks
- Mark `handle` method as `nonisolated` to meet Swift 6 Sendable requirements
- Remove redundant `DispatchQueue.main.async` wrappers (Flutter already dispatches on main thread)
- Fix Android Gradle build failures on Flutter's latest version
- Replace `withInputStream` with `inputStream().use` in Kotlin DSL settings
- Update Gradle wrapper from 7.5 to 9.4.1 for AGP 9.2.0 compatibility
- Fix Gradle 9.x `buildDir` type mismatch (String → File) in build scripts
- Upgrade Kotlin plugin from 2.2.10 to 2.2.20 to match Flutter compatibility requirements
## 1.1.4 - 2026-06-12

* Remove SPM build artifacts from git tracking
* Remove SPM build artifacts from git tracking
## 1.1.3 - 2026-06-12

* Chore: published 1.1.2
* performance imrovement, better ios Safari text handling
* optimizations on ios and android
* updated sagari string
* changelog
* fixed default value
* 🔥 ZIKZAK REFACTOR DETONATION v1.1.0 - Complete ecosystem rebrand from webview to zikzak with Apache 2.0 licensing, ARRRRNY authorship, and zero compromise architecture
* new plugin
* webview_useragentの公開情報を修正
* androidの公開情報を修正
* iosの公開情報を修正
* platform_interfaceの公開情報を修正
* READMEを追加
* ライセンスを追加
* androidのpluginを外部に切り出し
* 微修正
* iOSのpluginを外部に切り出し
* webviewのuaを取得
* add webview_useragent initial plugin
## 1.1.2
 - Performance improvment, better error handling
 - 
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
