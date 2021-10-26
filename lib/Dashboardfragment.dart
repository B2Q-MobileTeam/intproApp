import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dashboard.dart';

import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:toast/toast.dart';

import 'listofbrands.dart';
import 'main.dart';
import 'model/AddTocartWidget.dart';
import 'model/listbands1.dart';
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

  final String apiURL =
      'https://www.binary2quantumsolutions.com/intpro/category.php';


  String token = "";




  Future getcartdetail()async {
    print("cart 2");
    var url = 'https://www.binary2quantumsolutions.com/intpro/cart_details.php';
    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'user_id':"80",
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

// cartcountvalue();

    print('items count $cartcount');

    //  counter=itemsWithout.length;

    // // print(itemsWithout.runtimeType);
    // print("length in dashboard ${itemsWithout.length}");

  }
  void checkprocess(newString) {
    setState(() {
     cartcount = newString;
      print('inner function $cartcount');
    });
  }
 // set string(String value) => setState(() => cartcount = value);



  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("value token $token");
      getcartdetail();
    });
  }
  // cartcountvalue() async{
  //   SharedPreferences Preferences = await SharedPreferences.getInstance();
  //   Preferences.setString("cartcount", cartcount);
  //   print('cartcount fragment 4 $cartcount');
  // }



  // Future logOut(BuildContext context) async {}
  // @override
  // void initState() {
  //   super.initState();
  //   getEmail();
  // }




  // Color iconcolor= Color(0xff5742af);
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



        // drawer: new Drawer(
        //     child: Material(
        //       child: ListView(
        //         children: [
        //           Container(
        //             child:  Column(
        //               children: <Widget>[
        //                 DrawerHeader(
        //                     child: Container(
        //                       height: 600,
        //                       decoration: BoxDecoration(
        //                           image: DecorationImage(
        //                             image: AssetImage(
        //                               "assets/logo1.png",
        //                             ),
        //                           )),
        //                     )),
        //                 new Column(children: drawerOptions)
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //
        // ),



        //body: _getDrawerItemWidget(_selectedDrawerIndex),

  }



  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    Fluttertoast.showToast(
        msg: "Logout Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }


  shares(BuildContext context)  {
    FlutterShare.share(
        title: 'Share our app',
        text: 'Share the App',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }





}


typedef void StringCallback(String val);


