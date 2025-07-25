import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class ZikzakUserAgentPlatform extends PlatformInterface {
  ZikzakUserAgentPlatform() : super(token: _token);

  static final _token = Object();

  static ZikzakUserAgentPlatform _instance = _DefaultZikzakUserAgent();

  static ZikzakUserAgentPlatform get instance => _instance;

  static set instance(ZikzakUserAgentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getPlatformUserAgent() {
    throw UnimplementedError(
      'getPlatformUserAgent() has not been implemented.',
    );
  }
}

class _DefaultZikzakUserAgent extends ZikzakUserAgentPlatform {
  _DefaultZikzakUserAgent();

  @override
  Future<String> getPlatformUserAgent() {
    return Future.value("default value");
  }
}
