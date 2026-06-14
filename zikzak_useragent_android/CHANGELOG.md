## 1.1.4 - 2026-06-12

- Remove SPM build artifacts from git tracking
- Remove SPM build artifacts from git tracking

## 1.1.3 - 2026-06-12

- Chore: published 1.1.2
- performance imrovement, better ios Safari text handling
- optimizations on ios and android
- updated sagari string
- changelog
- fixed default value
- 🔥 ZIKZAK REFACTOR DETONATION v1.1.0 - Complete ecosystem rebrand from webview to zikzak with Apache 2.0 licensing, ARRRRNY authorship, and zero compromise architecture
- new plugin
- webview_useragentの公開情報を修正
- androidの公開情報を修正
- iosの公開情報を修正
- platform_interfaceの公開情報を修正
- READMEを追加
- ライセンスを追加
- androidのpluginを外部に切り出し
- 微修正
- iOSのpluginを外部に切り出し
- webviewのuaを取得
- add webview_useragent initial plugin

## 1.1.2

- Performance improvment, better error handling
-

## 1.1.0

### 🔥 ZIKZAK ANDROID IMPLEMENTATION REFACTOR 🔥

**BREAKING CHANGES:**

- **PACKAGE RENAME**: `webview_useragent_android` → `zikzak_useragent_android`
- **CLASS RENAME**: `WebviewUserAgentPlugin` → `ZikzakUserAgentPlugin`
- **METHOD CHANNEL**: Updated from `webview_useragent` to `zikzak_useragent`
- **IMPORT PATHS**: Updated platform interface import to `zikzak_useragent_platform_interface`
- **DART CLASS**: `WebviewUserAgentAndroid` → `ZikzakUserAgentAndroid`
- **PACKAGE PATH**: Kotlin classes moved to `dev.zuzu.zikzak_useragent_android.zikzak_useragent_android`

**ANDROID-SPECIFIC IMPROVEMENTS:**

- ✅ Enhanced WebView settings extraction with better null safety
- ✅ Improved Kotlin code structure and documentation
- ✅ Memory-efficient WebView initialization with application context
- ✅ Thread-safe async result handling
- ✅ Optimized method channel communication

**TECHNICAL UPDATES:**

- **Kotlin**: Latest stable version
- **Android API**: Minimum 19+ (Android 4.4)
- **Target SDK**: 33+
- **Architecture**: Clean Architecture compliance
- **WebView**: System WebView integration

**PERFORMANCE ENHANCEMENTS:**

- **Lazy Loading**: WebView created only when needed
- **Context Optimization**: Application context for proper lifecycle
- **Memory Footprint**: Minimal resource usage
- **Error Recovery**: Graceful handling of WebView failures
- **Null Safety**: Comprehensive null checking

**MIGRATION GUIDE:**

```kotlin
// OLD (v1.0.0)
package dev.zuzu.webview_useragent_android.webview_useragent_android
class WebviewUserAgentPlugin: FlutterPlugin, MethodCallHandler {
    val channel = MethodChannel(binding.binaryMessenger, "webview_useragent")
}

// NEW (v1.1.0)
package dev.zuzu.zikzak_useragent_android.zikzak_useragent_android
class ZikzakUserAgentPlugin: FlutterPlugin, MethodCallHandler {
    val channel = MethodChannel(binding.binaryMessenger, "zikzak_useragent")
}
```

```dart
// OLD Dart Implementation
import 'package:webview_useragent_platform_interface/webview_useragent_platform_interface.dart';
class WebviewUserAgentAndroid extends WebviewUserAgentPlatform { }

// NEW Dart Implementation
import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';
class ZikzakUserAgentAndroid extends ZikzakUserAgentPlatform { }
```

**PUBSPEC CHANGES:**

- **Package Name**: `zikzak_useragent_android`
- **Plugin Implementation**: `zikzak_useragent`
- **Dart Plugin Class**: `ZikzakUserAgentAndroid`
- **Plugin Class**: `ZikzakUserAgentPlugin`

**ARCHITECTURE IMPROVEMENTS:**

- ✅ Clean separation of concerns
- ✅ Enhanced error handling patterns
- ✅ Improved lifecycle management
- ✅ Better memory management
- ✅ Thread-safe operations

**TESTING UPDATES:**

- ✅ Updated integration tests for new class names
- ✅ Enhanced test coverage for error scenarios
- ✅ Improved Flutter integration testing

**COMPATIBILITY:**

- **Android Versions**: 4.4+ (API 19+)
- **Architecture**: ARM, ARM64, x86, x86_64
- **WebView**: System WebView and Chrome Custom Tabs
- **Flutter**: >=3.19.0

**AUTHOR**: ARRRRNY  
**WEBSITE**: zuzu.dev  
**EMAIL**: arrrrny@zuzu.dev

---

**Native Android precision. WebView mastery. Zero compromise.**

## 1.0.0

- Initial release.
