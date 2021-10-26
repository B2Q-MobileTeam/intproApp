// import 'package:flutter/material.dart';
// class Hello extends StatefulWidget{
//   String payment_statuss,payment_request_ids,payment_ids;
//   Hello({this.payment_statuss,this.payment_request_ids,this.payment_ids});
//   @override
//   State<StatefulWidget> createState() {
//     return HelloState();
//   }
// }
// class HelloState extends State<Hello>{
//   String paymentstatus,paymentreqid,paymentid;
//   @override
//   Widget build(BuildContext context) {
//     paymentstatus=widget.payment_statuss;
//     paymentreqid=widget.payment_request_ids;
//     paymentid=widget.payment_ids;
//     return Scaffold(
//       body:Center(
//         child:Column(
//           children: [
//             Text(paymentstatus),
//             Text(paymentreqid),
//             Text(paymentid),
//           ],
//         ) ,
//       ),
//     );
//   }
//
// }

// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../successpage.dart';
// import 'heloo.dart';
//
// class Nextstep extends StatefulWidget {
//   String paymenturl,redirect;
//   Nextstep({this.paymenturl,this.redirect});
//   @override
//   State<StatefulWidget> createState() {
//     return NextState();
//   }
// }
//
// class NextState extends State<Nextstep> {
//
//   String paymentpay;
//   String payredirect;
//   WebViewController controller;
//   String _initial = 'sample test';
//   var payment_id,payment_status,payment_request_id;
//
//   final flutterWebviewPlugin = new FlutterWebviewPlugin();
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   StreamSubscription<String> _onUrlChanged;
//   @override
//   void initState() {
//     super.initState();
//
//
//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) {
//         print("Current URL: $url");
//
//         if(url.contains("paymentResponse")){
//                    flutterWebviewPlugin.close();
//                     print("cur $url");
//                    var hana = url;
//                    print(hana);
//                    var hana1 =  hana.split("?");
//                    print(hana1[1]);
//                    var hana2 = hana1[1];
//                    var hana3 = hana2.split("&");
//                    print(hana3);
//                    var hana4 = hana3[0].split("=");
//                    var hana5 = hana3[1].split("=");
//                    var hana6 = hana3[2].split("=");
//                     payment_id = hana4[1];
//                     payment_status = hana5[1];
//                     payment_request_id = hana6[1];
//                    print('payment id $payment_id');
//                    print('payment status $payment_status');
//                    print('payment request id $payment_request_id');
//                    if(payment_status =="Credit"){
//                      print("Success");
//                      Hellosam();
//
//                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Hello()));
//                    }else{
//                      print("Failure");
//                    }
//         }
//       }
//     });
//   }
//
//   Hellosam(){
//     print("hellosam");
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(
//       payment_statuss:payment_status,
//       payment_request_ids:payment_request_id,
//       payment_ids:payment_id
//
//     )));
//   }
//   @override
//   Widget build(BuildContext context) {
//     paymentpay = widget.paymenturl;
//     payredirect = widget.redirect;
//     print('paymentfinal $paymentpay');
//     return Scaffold(
//
//       body: Padding(
//         padding: EdgeInsets.all(1.0),
//           child: Container(
//             padding: EdgeInsets.all(10.0),
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: WebviewScaffold(
//           url: paymentpay,
//              ),
//           )),
//     );
//   }
// }
//
//





import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../successpage.dart';
import 'heloo.dart';

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
  String _initial = 'sample test';
  var payment_id,payment_status,payment_request_id,payment_message,payment_order_id,payment_transaction_id,
      payment_transaction_date,payment_amount,payment_buyername,payment_invoice;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;
  @override
  void initState() {
    super.initState();


    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print("Current URL: $url");

        if (url.contains("paymentResponse")) {
          flutterWebviewPlugin.close();
          print("cur $url");
          var varurl = url;
          print('url1 $varurl');
          var one = varurl.split("?");
          print('one ${one[1]}');
          var paytwo = one[1];
          print('two ${paytwo[1]}');
          var paythree = paytwo.split("&");
          print('three ${paythree[1]}');
          print(paythree);
          var payfour = paythree[0].split("=");
          var payfive = paythree[1].split("=");
          var paysix = paythree[2].split("=");
          var payseven =paythree[3].split("=");
          var payeight =paythree[4].split("=");
          var paynine =paythree[5].split("=");
          var payten =paythree[6].split("=");
          var payinvoice =paythree[7].split("=");
          print("values pay,meny $payfour $payfive $paysix $payseven $payeight $paynine $payten $payinvoice");
          payment_status = payfour[1];
          payment_message = payfive[1];
          payment_order_id = paysix[1];
          payment_transaction_id=payseven[1];
          payment_transaction_date=payeight[1];
          payment_amount=paynine[1];
          payment_buyername=payten[1];
          payment_invoice=payinvoice[1];
          print("values pay,meny $payment_status $payment_message $payment_order_id $payment_transaction_id "
              "$payment_transaction_date $payment_amount $payment_buyername $payment_invoice");
          print('payment id $payment_id');
          print('payment status $payment_status');
          print('payment request id $payment_request_id');
          print('payment $payment_status');
          if (payment_status == 1) {
            print("Success");
            Hellosam();

            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Hello()));
          } else {
            print("Failure");
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
        payment_transaction_date:payment_transaction_date,
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


