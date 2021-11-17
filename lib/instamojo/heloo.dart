import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../NoInternet.dart';
import '../connectivity_provider.dart';
import '../successpage.dart';


class Nextsteps extends StatefulWidget {
  String paymenturl,redirect;
  Nextsteps({this.paymenturl,this.redirect});
  @override
  State<StatefulWidget> createState() {
    return NextStates();
  }
}

class NextStates extends State<Nextsteps> {

  String paymentpay;
  String payredirect;
  WebViewController controller;
  String name_pay,email_pay;
  String _initial = 'sample test';
  var payment_id,payment_status,payment_request_id,payment_message,payment_order_id,payment_transaction_id,
      payment_transaction_date,payment_amount,payment_buyername,payment_invoice;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
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
          payment_message="Invoice sent to $email_pay";
          payment_transaction_id = uri.queryParameters['transactionid'];
          payment_amount = uri.queryParameters['amount'];
          payment_transaction_date = uri.queryParameters['transaction_date'];
          payment_buyername= name_pay;
          payment_invoice = "https://www.binary2quantumsolutions.com/intpro/uploaded/${payment_order_id}.pdf";


          print("values pay,meny $payment_status $payment_message $payment_order_id $payment_transaction_id "
              "$payment_transaction_date $payment_amount $payment_buyername $payment_invoice");

          if (payment_status == "1") {
            print("Success");
            Hellosam();

          } else if(payment_status=="0") {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Failurescreeen()),(route)=>false);
            print("Failure status");
          }
        }
      }
    });
    //}
  }

  Hellosam(){
    print("hellosam");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyHomePage(
        payment_status:payment_status,
        payment_message:payment_message,
        payment_order_id:payment_order_id,
        payment_transaction_id:payment_transaction_id,
        //payment_transaction_date:payment_transaction_date,
        payment_amount:payment_amount,
        payment_buyername:payment_buyername,
        payment_invoice:payment_invoice

    )),(route)=>false);
  }
  @override
  Widget build(BuildContext context) {
    paymentpay = widget.paymenturl;
    payredirect = widget.redirect;
    print('paymentfinal $paymentpay');
    return Consumer<ConnectivityProvider>(
      builder: (context,model,child){
        if(model.isOnline!=null){
          return model.isOnline?
          WebviewScaffold(
            url: paymentpay,
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
}


