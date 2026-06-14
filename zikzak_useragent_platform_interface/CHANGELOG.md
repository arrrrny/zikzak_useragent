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
 - Optimizations on IOS and Android
 - 
## 1.1.1
 - Fixed default value
 - 
## 1.1.0

### 🔥 ZIKZAK PLATFORM INTERFACE REFACTOR 🔥

**BREAKING CHANGES:**
- **PACKAGE RENAME**: `webview_useragent_platform_interface` → `zikzak_useragent_platform_interface`
- **CLASS RENAME**: `WebviewUserAgentPlatform` → `ZikzakUserAgentPlatform`
- **EXPORT UPDATES**: Updated all import/export paths to use `zikzak_` prefix
- **DEFAULT IMPLEMENTATION**: `_DefaultWebviewUserAgent` → `_DefaultZikzakUserAgent`

**IMPROVEMENTS:**
- ✅ Enhanced abstract contract definition
- ✅ Improved error handling with descriptive UnimplementedError
- ✅ Better code formatting and documentation
- ✅ Streamlined platform registration system
- ✅ Type-safe method signatures

**TECHNICAL UPDATES:**
- **Dependencies**: Updated to plugin_platform_interface ^2.1.8
- **Dart SDK**: Requires ^3.3.0
- **Flutter**: Requires >=3.19.0
- **Architecture**: Full Clean Architecture compliance

**MIGRATION GUIDE:**
```dart
// OLD (v1.0.0)
import 'package:webview_useragent_platform_interface/webview_useragent_platform_interface.dart';
class MyImpl extends WebviewUserAgentPlatform { }

// NEW (v1.1.0)
import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';
class MyImpl extends ZikzakUserAgentPlatform { }
```

**PLATFORM IMPLEMENTATIONS UPDATED:**
- `zikzak_useragent_ios`: iOS WKWebView implementation
- `zikzak_useragent_android`: Android WebView implementation

**AUTHOR**: ARRRRNY  
**WEBSITE**: zuzu.dev  
**EMAIL**: arrrrny@zuzu.dev  

---

**Clean interfaces. Zero compromise. Maximum efficiency.**

## 1.0.0

* Initial release.
