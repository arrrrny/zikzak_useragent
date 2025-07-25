import 'package:flutter/services.dart';
import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';

class ZikzakUserAgentIOS extends ZikzakUserAgentPlatform {
  ZikzakUserAgentIOS();

  final methodChannel = MethodChannel("zikzak_useragent");

  static void registerWith() {
    ZikzakUserAgentPlatform.instance = ZikzakUserAgentIOS();
  }

  @override
  Future<String> getPlatformUserAgent() async {
    String userAgent = await methodChannel.invokeMethod("getPlatformUserAgent");
    return userAgent += ' Safari/604.1';
  }
}
