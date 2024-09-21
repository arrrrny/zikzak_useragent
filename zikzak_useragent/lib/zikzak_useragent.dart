import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';

class WebviewUserAgent {
  Future<String?> getPlatformUserAgent() async {
    return await WebviewUserAgentPlatform.instance.getPlatformUserAgent();
  }
}
