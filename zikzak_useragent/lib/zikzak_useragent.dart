import 'package:zikzak_useragent_platform_interface/zikzak_useragent_platform_interface.dart';

class ZikzakUserAgent {
  Future<String?> getPlatformUserAgent() async {
    return await ZikzakUserAgentPlatform.instance.getPlatformUserAgent();
  }
}
