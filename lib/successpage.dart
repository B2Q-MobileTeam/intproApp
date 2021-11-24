import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intpro_app/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'Dashboardfragment.dart';
import 'NoInternet.dart';
import 'dashboard.dart';
import 'model/myorderlist.dart';
import 'order_detail.dart';


class MyHomePage extends StatefulWidget {
  String payment_status,payment_message,payment_order_id,payment_transaction_id,payment_amount,payment_buyername,payment_invoice;
//payment_transaction_date
  MyHomePage({this.payment_status, this.payment_message, this. payment_order_id,this.payment_transaction_id,
    //this.payment_transaction_date,
    this.payment_amount,this.payment_buyername,this.payment_invoice});



  @override
  _MyHomePageState createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  bool waitingforstatus;
  String dis_pay_status,dis_pay_order_id,dis_pay_message,dis_pay_trans_id,dis_pay_trans_date,dis_pay_amnt,dis_pay_buyname,dis_pay_invoice;


  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context)
  {
    dis_pay_status=widget.payment_status;
    print("status $dis_pay_status");
    dis_pay_message=widget.payment_message;
    dis_pay_order_id=widget.payment_order_id;
    dis_pay_trans_id=widget.payment_transaction_id;
    //dis_pay_trans_date=widget.payment_transaction_date;
    dis_pay_amnt=widget.payment_amount;
    dis_pay_buyname=widget.payment_buyername;
    dis_pay_invoice=widget.payment_invoice;


    return
      Consumer<ConnectivityProvider>(
        builder: (context,model,child){
          if(model.isOnline!=null){
            return model.isOnline?

            WillPopScope(
                onWillPop: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homee(),
                      ),(route)=>false
                  );
                },
         child:   Scaffold(
              appBar: AppBar(
                title: Text("Intpro"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homee(),
                        ),(route)=>false
                    );
                  },
                ),
              ),
              body: Container(
                  padding: EdgeInsets.only(top:20,left: 10,right: 10,bottom: 10),
                  child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/succtwo.gif',
                            height: MediaQuery.of(context).size.height/5,
                            width: 400.0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Payment Successful!',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                                fontSize: 30.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child:  Container(
                            padding: EdgeInsets.all(10),
                            child:  Text('$dis_pay_message',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Paid By',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500),),
                                Text('$dis_pay_buyname',style: TextStyle(fontSize: 15.0),),
                              ],
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Oredr Id ',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500),),
                                Text('$dis_pay_order_id',style: TextStyle(fontSize: 15.0),),
                              ],
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Transaction Id',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500),),
                                Text('$dis_pay_trans_id',style: TextStyle(fontSize: 15.0),),
                              ],
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Amount',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500),),
                                Text('$dis_pay_amnt',style: TextStyle(fontSize: 15.0),),
                              ],
                            )
                        ),


                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.only(top: 15),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyOrderListprocess()),(route)=>false);
                                },
                                color: Colors.blue,
                                child: Text("Ok"),
                              ),
                            )
                        )
                      ],

                    )),
            ))

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


class Failurescreeen extends StatefulWidget {
  @override
  _FailurescreeenState createState() => _FailurescreeenState();
}

class _FailurescreeenState extends State<Failurescreeen> {
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context,model,child){
        if(model.isOnline!=null){
          return model.isOnline?
          WillPopScope(
              onWillPop: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homee(),
                    ),(route)=>false
                );
              },
        child:  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Intpro"),
              leading:IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyOrder()),(route)=>false);
                },

              ),
            ),
            body: Container(
                padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,


                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/error_img.gif',
                          height: MediaQuery.of(context).size.height/3,
                          width: 400.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Payment Failed!',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                              fontSize: 28.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Oops! Somethings went wrong.',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              fontSize: 18.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Your Transacation is failed,',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                              fontSize: 18.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Try again',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                              fontSize: 18.0),
                        ),
                      ),


                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyOrder()),(route)=>false);
                              },
                              color: Colors.blue,
                              child: Text("Ok"),
                            ),
                          )
                      )
                    ],

                  )),
          ))
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
