import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RheaWebView extends StatefulWidget {
  const RheaWebView({super.key, required this.url});
  final String url;

  @override
  State<RheaWebView> createState() => _RheaWebViewState();
}

class _RheaWebViewState extends State<RheaWebView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: _completer.complete,
          ),
        ),
      );
}
