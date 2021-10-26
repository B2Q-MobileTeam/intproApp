import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.binary2quantumsolutions.com/B2Qproduct/intproweb',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {

      },

    );
  }
}
