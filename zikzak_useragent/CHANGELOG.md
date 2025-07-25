## 1.1.0

### 🔥 ZIKZAK REFACTOR DETONATION 🔥

**BREAKING CHANGES:**
- **COMPLETE REBRAND**: Migrated from `webview_useragent` to `zikzak_useragent`
- **CLASS NAMES**: `WebviewUserAgent` → `ZikzakUserAgent`
- **PACKAGE NAMES**: All packages now use `zikzak_useragent_*` naming
- **METHOD CHANNELS**: Updated to `zikzak_useragent` channel name
- **IMPORT PATHS**: Update imports to `package:zikzak_useragent/zikzak_useragent.dart`

**IMPROVEMENTS:**
- ✅ Enhanced iOS implementation with Safari suffix detection
- ✅ Optimized Android WebView initialization
- ✅ Improved error handling and type safety
- ✅ Updated documentation with ZIKZAK manifesto
- ✅ Clean architecture compliance
- ✅ Memory-efficient native implementations

**PLATFORM UPDATES:**
- **iOS**: WKWebView-based extraction with Safari/604.1 suffix
- **Android**: WebView.settings-based extraction
- **Platform Interface**: Streamlined abstract contracts

**MIGRATION GUIDE:**
```dart
// OLD (v1.0.0)
import 'package:webview_useragent/webview_useragent.dart';
final plugin = WebviewUserAgent();

// NEW (v1.1.0)
import 'package:zikzak_useragent/zikzak_useragent.dart';
final plugin = ZikzakUserAgent();
```

**TECHNICAL DEBT ELIMINATION:**
- 🗑️ Removed legacy webview references
- 🗑️ Cleaned up redundant package dependencies
- 🗑️ Optimized native code structure
- 🗑️ Eliminated unnecessary abstractions

**AUTHOR**: ARRRRNY  
**WEBSITE**: zuzu.dev  
**EMAIL**: arrrrny@zuzu.dev  

---

**This isn't development—it's unfiltered violence against the mundane.**

## 1.0.0

* Initial release.