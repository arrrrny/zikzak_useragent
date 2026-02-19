package com.strysk.zikzak_useragent_android.zikzak_useragent_android

import android.webkit.WebSettings

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class ZikzakUserAgentPlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var applicationContext: android.content.Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zikzak_useragent")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformUserAgent") {
            try {
                val userAgent = WebSettings.getDefaultUserAgent(applicationContext)
                if (userAgent != null) {
                    result.success(userAgent)
                } else {
                    result.error("USER_AGENT_ERROR", "Failed to get user agent", null)
                }
            } catch (e: Exception) {
                result.error("USER_AGENT_ERROR", e.message, null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        applicationContext = null
    }
}
