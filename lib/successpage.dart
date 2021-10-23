import 'package:flutter/material.dart';
import 'Dashboardfragment.dart';
import 'dashboard.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.payment_ids,this.payment_request_ids,this.payment_statuss}) : super(key: key);
  final String title;
  String payment_statuss;
  String payment_request_ids;
  String payment_ids;

  @override
  @override
  _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  String payid;


  @override
  Widget build(BuildContext context) {
    payid=widget.payment_ids;
    return Scaffold(
//appBar: AppBar(),
      body: Center(
        child: ListView(shrinkWrap: true, children: [
          Column(
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
              Text('payment ID : $payid',style: TextStyle(fontSize: 15.0),),
              Padding(
                padding:
                const EdgeInsets.only(left: 40.0, right: 40.0, top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Text(
                          'Product Name: ',
                          style: TextStyle(fontSize: 20.0),
                        )),
                    Container(
                        child:
                        Text('Plywood', style: TextStyle(fontSize: 18.0))),
                  ],
                ),
              ),

              Padding(
                padding:
                const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Text(
                          'Amount Paid : ',
                          style: TextStyle(fontSize: 20.0),
                        )),
                    Container(
                        child: Text('1256', style: TextStyle(fontSize: 18.0))),
                  ],
                ),
              ),
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