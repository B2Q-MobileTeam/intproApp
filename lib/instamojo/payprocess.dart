import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'nextstep.dart';



class Payprocess extends StatefulWidget {
  @override
  PayprocessState createState() => PayprocessState();
}

class PayprocessState extends State<Payprocess> {
  String _paymentResponse = 'Unknown';

  void register() {
    var url = 'https://www.binary2quantumsolutions.com/intpro/pay.php';
    print('url $url');

    http.post(Uri.parse(url), body: {
      "userName": "admin",
      "payAmount": "10",
      "userMobile":"9876543210",
      "userEmail":"b2q@gmail.com",
      "userId":"1",
      "purpose":"plywoods"

    }).then((res) {
      var resJson = json.decode(res.body);
      print('resj $resJson');
      var paymentprocess = resJson['payment_request']['longurl'];
      print('resjosn $paymentprocess');
      var redirecturlinsta = resJson['payment_request']['redirect_url'];
      print('redirecturlinsta $redirecturlinsta');

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Nextstep(
      paymenturl: paymentprocess,
        redirect:redirecturlinsta,
    )));

    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Hello()));


    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RaisedButton(
            onPressed: () {
              print("clicked");
              //register();
            },
            color: Colors.pink[100],
            child: Text("Clicbxdgxgxdk"),
          ),
        ),
      ),
    );
  }
}
