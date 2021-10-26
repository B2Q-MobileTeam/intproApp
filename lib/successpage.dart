import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Dashboardfragment.dart';
import 'dashboard.dart';


class MyHomePage extends StatefulWidget {
  String payment_status,payment_message,payment_order_id,payment_transaction_id,
      payment_transaction_date,payment_amount,payment_buyername,payment_invoice;

  MyHomePage({this.payment_status, this.payment_message, this. payment_order_id,this.payment_transaction_id,this.payment_transaction_date,
    this.payment_amount,this.payment_buyername,this.payment_invoice});



  @override
  _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  String dis_pay_status,dis_pay_order_id,dis_pay_message,dis_pay_trans_id,dis_pay_trans_date,dis_pay_amnt,dis_pay_buyname,dis_pay_invoice;


  @override
  Widget build(BuildContext context) {
    dis_pay_status=widget.payment_status;
    dis_pay_message=widget.payment_message;
    dis_pay_order_id=widget.payment_order_id;
    dis_pay_trans_id=widget.payment_transaction_id;
    dis_pay_trans_date=widget.payment_transaction_date;
    dis_pay_amnt=widget.payment_amount;
    dis_pay_buyname=widget.payment_buyername;
    dis_pay_invoice=widget.payment_invoice;


    return Scaffold(
//appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
        child: ListView(shrinkWrap: true, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/succimg.jpg',
                  height: 120.0,
                  width: 120.0,
                ),
              ),
              Text(
                'Payment Successful!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 30.0),
              ),
              Text('Payment Message : $dis_pay_message',style: TextStyle(fontSize: 15.0),),
              Text('Order Id : $dis_pay_order_id',style: TextStyle(fontSize: 15.0),),
              Text('Transaction Id : $dis_pay_trans_id',style: TextStyle(fontSize: 15.0),),
              Text('Transaction Date : $dis_pay_trans_date',style: TextStyle(fontSize: 15.0),),
              Text('Amount : $dis_pay_amnt',style: TextStyle(fontSize: 15.0),),
              Text('Buyer Name : $dis_pay_buyname',style: TextStyle(fontSize: 15.0),),
            Text('Invoice Url : $dis_pay_invoice',style: TextStyle(fontSize: 15.0),),



              Container(
                padding: EdgeInsets.only(top: 15),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JsonImageList()));
                  },
                  color: Colors.blue,
                  child: Text("Ok"),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}