@preconcurrency import Flutter
import UIKit
import WebKit

/// Boxes a FlutterResult so the `@Sendable` WebKit completion closures can
/// carry it across the async hop. FlutterResult itself is not Sendable; the
/// reply is delivered at most once, from the WebKit main-queue completions
/// or from the watchdog, whichever wins.
///
/// All `reply` calls run on the main thread (WebKit completion queues and
/// the watchdog below), so the once-guard needs no lock.
private final class ResultBox: @unchecked Sendable {
    nonisolated(unsafe) let result: FlutterResult
    nonisolated(unsafe) private var replied = false

    init(_ result: @escaping FlutterResult) { self.result = result }

    func reply(_ make: () -> Any) {
        if replied { return }
        replied = true
        result(make())
    }
}

public class ZikzakUserAgentPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "zikzak_useragent", binaryMessenger: registrar.messenger())
        let instance = ZikzakUserAgentPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    nonisolated public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformUserAgent":
            // Box the result HERE, in the nonisolated body: `result` must
            // never be captured by the main-actor closure below, because the
            // WebKit completions that finally invoke it are nonisolated —
            // a main-actor capture followed by a nonisolated use trips
            // Swift 6's region analysis ("sending 'result' risks causing
            // data races"). Only the Sendable box crosses the boundaries.
            let box = ResultBox(result)
            // Flutter dispatches platform-channel calls on the main thread,
            // so the WKWebView creation and the async JS evaluation below run
            // on the main actor — assert that once up front.
            MainActor.assumeIsolated {
                let webView = WKWebView(frame: .zero)
                // Snapshot the legacy KVC template BEFORE the async hop: it is
                // only the last-resort fallback.
                let fallbackTemplate = webView.value(forKey: "userAgent") as? String
                // navigator.userAgent is what the engine actually puts on
                // every request and what pages see — the string servers must
                // accept. The `value(forKey:"userAgent")` template above can
                // disagree with it (stale OS token, missing Version
                // component); scraping targets fingerprint that mismatch, so
                // navigator.userAgent is the source of truth.
                //
                // Retry, don't fire-once: evaluateJavaScript on a
                // never-loaded WKWebView can return nil at app cold-start
                // while the web content process is still booting (observed
                // on the iOS 26.3 simulator). Retrying on the main queue
                // gives the process time to spawn; the 8s watchdog below
                // still bounds the total wait.
                func evaluateWithRetry(_ attempt: Int) {
                    webView.evaluateJavaScript("navigator.userAgent") { value, _ in
                        if let ua = value as? String, !ua.isEmpty {
                            box.reply { ua }
                            return
                        }
                        if attempt < 12 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                evaluateWithRetry(attempt + 1)
                            }
                        }
                        // Retries exhausted → the watchdog delivers the
                        // template fallback.
                    }
                }
                evaluateWithRetry(0)
                // Watchdog: on a wedged WebKit stack the completions above may
                // never fire — answer with the template instead of hanging
                // the platform channel. UserAgentCache does not lock the
                // fallback in, so a later call can still recover the live UA.
                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    box.reply {
                        fallbackTemplate.map { Self.appendSafariVersion(to: $0) }
                            ?? FlutterError(
                                code: "USER_AGENT_ERROR",
                                message: "Failed to get user agent",
                                details: nil) as Any
                    }
                }
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private static func appendSafariVersion(to userAgent: String) -> String {
        if let range = userAgent.range(of: "AppleWebKit/") {
            let versionStart = range.upperBound
            let versionEnd = userAgent[versionStart...].firstIndex(of: " ") ?? userAgent.endIndex
            let webKitVersion = String(userAgent[versionStart..<versionEnd])
            return userAgent + " Safari/" + webKitVersion
        }
        return userAgent
    }
}
