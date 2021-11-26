import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intpro_app/Dashboardfragment.dart';
import 'package:intpro_app/Url.dart';
import 'package:intpro_app/connectivity_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../NoInternet.dart';
import '../dashboard.dart';
import '../drawer.dart';
import 'DetailOrderPage.dart';
import 'Modelclass.dart';


class MyOrderListprocess extends StatefulWidget {

  @override
  MyOrderListprocessState createState() => MyOrderListprocessState();
}

class MyOrderListprocessState extends State<MyOrderListprocess> {
  String token;
  var loading = false;
  var _iswaiting=true;
  List<Order> listModel = [];

  Future<Null> getData() async{
    print('url ${ApiCall.OrderDetails}');
    print('token $token');
    setState(() {
      loading = true;
    });

    final responseData = await http.post(Uri.parse
      (ApiCall.OrderDetails),
        body: {
          'user_id':token
        }
    );


    final data = jsonDecode(responseData.body);
    print("data 1 $data");
    final order_status= data['status'];
    print("order status $order_status");
    final ordersdata  =data['orders'];
    print("data $ordersdata");

    if(order_status=="true"){
      setState(() {
        for(Map i in ordersdata){
          listModel.add(Order.fromJson(i));
        }
        loading = false;
        _iswaiting=false;
      });
    }else{
      setState(() {
        _iswaiting=false;
      });

    }

  }

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
    super.initState();
    getEmail();


  }

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("value token $token");
      getData();
    });
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
                  elevation: 0.0,
                  title: Text('Your Orders',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22.0,
                          color: Colors.white)),

                  actions: [
                    DashboardFragment()
                  ],
                  centerTitle: true,
                ),
                drawer: Drawer_main(),
                body:SafeArea(
                    child:_iswaiting?Center(
                      child: CircularProgressIndicator(),
                    ):Container(
                      color: Colors.white,
                      child: loading ?
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top:20),
                              child: Image.network(ApiCall.myorders),
                              // decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //       image: AssetImage("assets/myorders.png"),
                              //       colorFilter: ColorFilter.mode(
                              //           Colors.white.withOpacity(0.8), BlendMode.dstATop),
                              //
                              //     )),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height/2,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("There is no order list",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
                            ),
                          ],
                        ),
                      )
                          : ListView.builder(
                          itemCount: listModel.length,
                          itemBuilder: (context, i){
                            final nDataList = listModel[i];

                            return Container(
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DetailOrderPage(
                                      dorderid:nDataList.orderid,
                                      dtransactionid:nDataList.transactionid,
                                      dtransactiondate:nDataList.transaction_date,
                                      dproduct:nDataList.product,
                                      dbrand:nDataList.brand,
                                      ditem:nDataList.item,
                                      dprice:nDataList.price,
                                      dquantity:nDataList.quantity,
                                      damount:nDataList.amount,
                                      dshipping: nDataList.shipping,
                                      dspecification:nDataList.specification,
                                      dinvoice:nDataList.invoice,
                                      dinvoicename:nDataList.invoicename
                                  )),(route)=>false);
                                },
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  margin: EdgeInsets.all(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blueAccent)
                                    ),
                                    padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Order ID -${nDataList.orderid}", style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54),
                                            ),

                                            Icon(Icons.arrow_right,color: Colors.grey,size: 25,),
                                          ],
                                        ),
                                        Divider(color: Colors.grey[300],thickness: 1,),
                                        Text("${nDataList.product}", style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("${nDataList.brand}", style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black45),
                                        ),
                                        SizedBox(height: 5,),
                                        Text("${nDataList.item==null?"":nDataList.item}", style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45),
                                        ),
                                        SizedBox(height:5,),
                                        Text("₹ ${nDataList.amount}", style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),

                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                            alignment: Alignment.bottomRight,
                                            child:ElevatedButton(
                                                onPressed: (){
                                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DetailOrderPage(
                                                      dorderid:nDataList.orderid,
                                                      dtransactionid:nDataList.transactionid,
                                                      dtransactiondate:nDataList.transaction_date,
                                                      dproduct:nDataList.product,
                                                      dbrand:nDataList.brand,
                                                      ditem:nDataList.item,
                                                      dprice:nDataList.price,
                                                      dquantity:nDataList.quantity,
                                                      damount:nDataList.amount,
                                                      dshipping: nDataList.shipping,
                                                      dspecification:nDataList.specification,
                                                      dinvoice:nDataList.invoice,
                                                      dinvoicename:nDataList.invoicename

                                                  )),(route)=>false);
                                                },
                                                child:Text("More Details")

                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    )
                ),
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