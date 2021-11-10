import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intpro_app/Dashboardfragment.dart';
import 'package:intpro_app/Url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    final ordersdata  =data['orders'];
    print("data $ordersdata");

    setState(() {
      for(Map i in ordersdata){
        listModel.add(Order.fromJson(i));
      }
      loading = false;
    });

  }

  @override
  void initState() {
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
    return Scaffold(
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
        child:  Container(
          color: Colors.grey[300],
          child: loading ? Center (child: CircularProgressIndicator()) : ListView.builder(
              itemCount: listModel.length,
              itemBuilder: (context, i){
                final nDataList = listModel[i];
                return Container(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOrderPage(
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
                      )));
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
                            Text("${nDataList.item}", style: TextStyle(
                                fontSize: 14,
                                color: Colors.black45),
                            ),
                            SizedBox(height: 5,),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailOrderPage(
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

                                    )));
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
        ),
      ),
    );
  }
}