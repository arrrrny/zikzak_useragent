import Flutter
import UIKit
import WebKit

public class ZikzakUserAgentPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "zikzak_useragent", binaryMessenger: registrar.messenger())
        let instance = ZikzakUserAgentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformUserAgent":
            DispatchQueue.main.async {
                let webView = WKWebView(frame: .zero)
                if let userAgent = webView.value(forKey: "userAgent") as? String {
                    result(self.appendSafariVersion(to: userAgent))
                } else {
                    result(FlutterError(code: "USER_AGENT_ERROR",
                                        message: "Failed to get user agent",
                                        details: nil))
                }
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func appendSafariVersion(to userAgent: String) -> String {
        if let range = userAgent.range(of: "AppleWebKit/") {
            let versionStart = range.upperBound
            let versionEnd = userAgent[versionStart...].firstIndex(of: " ") ?? userAgent.endIndex
            let webKitVersion = String(userAgent[versionStart..<versionEnd])
            return userAgent + " Safari/" + webKitVersion
        }
        return userAgent
    }
}
