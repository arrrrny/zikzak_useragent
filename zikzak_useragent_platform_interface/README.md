# 🔥 ZikZak UserAgent Platform Interface 🔥

**The Abstract Foundation of UserAgent Extraction Excellence**

A common platform interface for the `zikzak_useragent` plugin that defines the contract between Flutter and native platform implementations.

## **PURPOSE**

This package provides the abstract base class and method signatures that all platform-specific implementations must follow. It's the **architectural backbone** that ensures consistency across iOS, Android, and future platforms.

## **ARCHITECTURE**

```dart
abstract class ZikzakUserAgentPlatform extends PlatformInterface {
  Future<String> getPlatformUserAgent();
}
```

### **Implementation Contract**

Every platform implementation MUST:
- Extend `ZikzakUserAgentPlatform`
- Implement `getPlatformUserAgent()` method
- Return a valid UserAgent string
- Handle platform-specific errors gracefully

## **PLATFORM IMPLEMENTATIONS**

| Package | Platform | Status |
|---------|----------|--------|
| `zikzak_useragent_ios` | iOS | ✅ **ACTIVE** |
| `zikzak_useragent_android` | Android | ✅ **ACTIVE** |

## **USAGE**

This package is **NOT** intended for direct use in applications. It's a foundational dependency used by:

1. **Main Plugin** (`zikzak_useragent`)
2. **Platform Implementations** (`zikzak_useragent_ios`, `zikzak_useragent_android`)

## **INTEGRATION**

Platform implementations register themselves:

```dart
// iOS Implementation
ZikzakUserAgentPlatform.instance = ZikzakUserAgentIOS();

// Android Implementation  
ZikzakUserAgentPlatform.instance = ZikzakUserAgentAndroid();
```

## **DEPENDENCIES**

- `flutter`: SDK framework
- `plugin_platform_interface`: ^2.1.8

## **VERSION**

Current: **1.1.0**

## **TECHNICAL SPECIFICATIONS**

- **Dart SDK**: ^3.3.0
- **Flutter**: >=3.19.0
- **Architecture**: Clean Architecture compliance
- **Error Handling**: UnimplementedError for missing implementations

## **CHANGELOG**

### v1.1.0 - ZIKZAK Refactor
- ✅ Rebranded from `webview_useragent_platform_interface`
- ✅ Updated class names: `WebviewUserAgentPlatform` → `ZikzakUserAgentPlatform`
- ✅ Enhanced documentation
- ✅ Improved type safety

## **LICENSE**

Apache License 2.0

## **CREDITS**

**Built by ARRRRNY** for the ZIKZAK ecosystem.

- **Website**: [zuzu.dev](https://zuzu.dev)
- **Email**: arrrrny@zuzu.dev
- **Repository**: [github.com/arrrrny/zikzak_useragent](https://github.com/arrrrny/zikzak_useragent)

---

**Pure abstraction. Maximum efficiency. Zero compromise.**

**WE ARE ZIKZAK.**