import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intpro_app/Url.dart';

import 'dashboard.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';


import 'main.dart';


import 'order_detail.dart';
import 'rate.dart';
class DashboardProducts {
  int id;
  String catergoryname;
  String flowerImageURL;
  String cid;
  String title;


  DashboardProducts(
      {this.id, this.cid, this.catergoryname, this.title, this.flowerImageURL});
  factory DashboardProducts.fromJson(Map<String, dynamic> json) {
    return DashboardProducts(
        id: json['id'],
        cid: json['cid'],
        catergoryname: json['category_name'],
        flowerImageURL: json['cat_img'],
        title: json['title']);
  }
}




class DashboardFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new DashboardFragmentState();


  static DashboardFragmentState of(BuildContext context) =>
      context.findAncestorStateOfType<DashboardFragmentState>();
}

class DashboardFragmentState extends State<DashboardFragment> {




  Future<List<DashboardProducts>> _products;
  String user_id,cartcount;
  int counter = 0;
  String token = "";




  Future getcartdetail()async {
    print("cart 2");

    final http.Response response = await http.post(
      Uri.parse(ApiCall.CartDetails),
      body: {
        'user_id':token,
      },
    );

    var resJson = json.decode(response.body);
    print("cart data");
    print('object $resJson');
    final items = resJson['cart_details'];
    print('cartdetails $items');
    final itemsWithout = resJson['cart_details'];
    var cartcart = resJson['data'];
    print('items product $cartcart');
    cartcount=cartcart;
    print('item cart 3');
    checkprocess(cartcart);



    print('items count $cartcount');


  }
  void checkprocess(newString) {
    setState(() {
     cartcount = newString;
      print('inner function $cartcount');
    });
  }




  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("value token $token");
      getcartdetail();
    });
  }










  int _selectedDrawerIndex = 0;




  @override
  void initState() {
    super.initState();
    getEmail();


  }

  @override
  Widget build(BuildContext context) {


    return

          Stack(
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.shopping_cart,
                color: Colors.white,),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyOrder()
                      )
                  );
                },
              ),
              cartcount==0 ? new Container() :
              new Positioned(

                  child: new Stack(
                    children: <Widget>[
                      new Icon(
                          Icons.brightness_1,
                          size: 25.0, color: Colors.red[800]),
                      new Positioned(
                          top: 3.0,
                          right: 4.0,
                          child: new Center(
                            child:
                            Text(cartcount.toString(), style: new TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500
                            ),),

                          )),
                    ],
                  )),

            ],
          );





  }






}


typedef void StringCallback(String val);


