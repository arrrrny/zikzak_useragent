import 'package:flutter/services.dart';
import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';

class ZikzakUserAgentMacOS extends ZikzakUserAgentPlatform {
  ZikzakUserAgentMacOS();

  final methodChannel = MethodChannel("zikzak_useragent");

  static void registerWith() {
    ZikzakUserAgentPlatform.instance = ZikzakUserAgentMacOS();
  }

  @override
  Future<String> getPlatformUserAgent() async {
    final userAgent = await methodChannel.invokeMethod("getPlatformUserAgent");
    return userAgent;
  }
}
