import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zikzak_useragent/zikzak_useragent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformUserAgent = 'Unknown';
  final _zikzakUserAgentPlugin = ZikzakUserAgent();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformUserAgent;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformUserAgent =
          await _zikzakUserAgentPlugin.getPlatformUserAgent() ??
          'Unknown platform UserAgent';
    } on PlatformException {
      platformUserAgent = 'Failed to get platform UserAgent.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformUserAgent = platformUserAgent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ZikZak UserAgent Plugin')),
        body: Center(child: Text(_platformUserAgent)),
      ),
    );
  }
}
