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