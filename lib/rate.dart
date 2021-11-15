import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'NoInternet.dart';
import 'connectivity_provider.dart';
class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<ConnectivityProvider>(
        builder: (context,model,child){
          if(model.isOnline!=null){
            return model.isOnline?
            WebView(
              initialUrl: 'https://www.binary2quantumsolutions.com/B2Qproduct/intproweb',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {

              },

            )
                :NoInternet();
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );


  }

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();

  }
}
