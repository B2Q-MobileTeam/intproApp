
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../successpage.dart';


class Nextstep extends StatefulWidget {
  String paymenturl,redirect;
  Nextstep({this.paymenturl,this.redirect});
  @override
  State<StatefulWidget> createState() {
    return NextState();
  }
}

class NextState extends State<Nextstep> {

  String name_pay,email_pay;

  String paymentpay;
  String payredirect;
  WebViewController controller;
  String _initial = 'sample test';
  var payment_id,payment_status,payment_request_id,payment_message,payment_order_id,payment_transaction_id,
      payment_transaction_date,payment_amount,payment_buyername,payment_invoice;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;

  void getpro() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name_pay = (prefs.getString('name1'));
    print('name1 $name_pay');
    email_pay = (prefs.getString('email'));
    print('email $email_pay');
  }
  @override
  void initState() {
    getpro();
    super.initState();


    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {

        print("Current URL: $url");
        if (url.contains("paymentResponse")) {

          flutterWebviewPlugin.close();
          print("cur $url");

          Uri uri = Uri.dataFromString(url);
          payment_status = uri.queryParameters['status'];
          print("payment_status $payment_status");
          payment_order_id = uri.queryParameters['orderid'];
          payment_message="Message sent to $email_pay";
          payment_transaction_id = uri.queryParameters['transactionid'];
          payment_amount = uri.queryParameters['amount'];
          payment_transaction_date = uri.queryParameters['transaction_date'];
          payment_buyername= name_pay;
          payment_invoice = "https://www.binary2quantumsolutions.com/intpro/uploaded/${payment_order_id}.pdf";
         // print("aa $aa $bb $cc $dd $ee $ff $gg");



          print("values payment $payment_status $payment_message $payment_order_id $payment_transaction_id "
              "$payment_transaction_date $payment_amount $payment_buyername $payment_invoice");

          if (payment_status == "1") {
            print("Success");
            Hellosam();

            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Hello()));
          }else if(payment_status=="0") {

            print("Failure status");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Failurescreeen()));
          }
        }
      }
    });
    //}
  }

  Hellosam(){
    print("hellosam");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(
        payment_status:payment_status,
        payment_message:payment_message,
        payment_order_id:payment_order_id,
        payment_transaction_id:payment_transaction_id,
        // payment_transaction_date:payment_transaction_date,
        payment_amount:payment_amount,
        payment_buyername:payment_buyername,
        payment_invoice:payment_invoice
    )));
  }


  @override
  Widget build(BuildContext context) {
    paymentpay = widget.paymenturl;
    payredirect = widget.redirect;
    print('paymentfinal $paymentpay');
    return WebviewScaffold(
                url: paymentpay,

    );
  }

}


