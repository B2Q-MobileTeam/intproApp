import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Url.dart';
import 'drawer.dart';
import 'order_detail.dart';
class ShareApp extends StatefulWidget {

  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {

  String token;
  shares(BuildContext context)  {
    FlutterShare.share(
        title: 'Share our app',
        text: 'Share the App',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }


  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("token $token");
      getcartdetail();
    });
  }

  Future getcartdetail() async {
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
    setState(() {
      cartcount = cartcart;
      shares(context);
    });

    print('item cart 3');

    print('items count $cartcount');
  }
  @override
  void initState() {
    getEmail();
  }

  var cartcount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        elevation: 0.0,
        title: Text('ShareApp',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22.0,
                color: Colors.white)),
        actions: [
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
                          size: 20.0, color: Colors.red[800]),
                      new Positioned(
                          top: 3.0,
                          right: 4.0,
                          child: new Center(
                            child:
                            Text(cartcount.toString(), style: new TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500
                            ),),

                          )),
                    ],
                  )),

            ],
          )
        ],
        centerTitle: true,
      ),
      drawer: Drawer_main(),
      body:  Container(
        padding: EdgeInsets.only(top:20),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Sharelink-pana.png"),
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),

            )),
        height: MediaQuery
            .of(context)
            .size
            .height/2,
        width: MediaQuery
            .of(context)
            .size
            .width,

      ),
    );
  }


}
