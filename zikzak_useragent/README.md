# 🔥 ZikZak UserAgent 🔥

**Raw. Efficient. Unyielding.**

A Flutter plugin that **detonates** the mundane by extracting native WebView UserAgent strings with surgical precision.

## **WTF IS THIS?**

We don't just "get" user agents—**we EXTRACT them with AI-powered efficiency.**

This plugin provides access to the native WebView UserAgent string on both iOS and Android platforms. No compromises. No "good enough" solutions.

## **INSTALLATION**

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  zikzak_useragent: ^1.1.0
```

## **USAGE**

```dart
import 'package:zikzak_useragent/zikzak_useragent.dart';

// Initialize the plugin
final zikzakUserAgent = ZikzakUserAgent();

// Extract the UserAgent (asynchronously)
String? userAgent = await zikzakUserAgent.getPlatformUserAgent();

print('Native UserAgent: $userAgent');
```

## **PLATFORM SUPPORT**

| Platform | Support | Implementation |
|----------|---------|----------------|
| ✅ **iOS** | **FULL** | WKWebView-based extraction |
| ✅ **Android** | **FULL** | WebView.settings extraction |

## **WHAT YOU GET**

### iOS Output Example:
```
Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari/604.1
```

### Android Output Example:
```
Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36
```

## **ARCHITECTURE**

Built on **Flutter Clean Architecture** principles:

- **Platform Interface**: Abstract contracts
- **Native Implementations**: iOS (Swift) + Android (Kotlin)
- **Dart Layer**: Type-safe Flutter integration

## **PERFORMANCE**

- **Zero Dependencies** on external WebView packages
- **Lazy Initialization** of native WebView instances
- **Async-First** API design
- **Memory Efficient** implementation

## **REQUIREMENTS**

- **Flutter**: >=3.19.0
- **Dart**: ^3.3.0
- **iOS**: >=12.0
- **Android**: API Level 19+

## **CONTRIBUTING**

We build what **shouldn't exist**—then make it **inevitable.**

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/wtf-improvement`)
3. Commit your changes (`git commit -m 'Add some WTF'`)
4. Push to the branch (`git push origin feature/wtf-improvement`)
5. Open a Pull Request

## **LICENSE**

Apache License 2.0

## **CREDITS**

**Built by ARRRRNY** for the ZIKZAK ecosystem.

- **Website**: [zuzu.dev](https://zuzu.dev)
- **Email**: arrrrny@zuzu.dev
- **Repository**: [github.com/arrrrny/zikzak_useragent](https://github.com/arrrrny/zikzak_useragent)

---

**This isn't just a plugin—it's unfiltered violence against the mundane.**

**WE ARE ZIKZAK.**