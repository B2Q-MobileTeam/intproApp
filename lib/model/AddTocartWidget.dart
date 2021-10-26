// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'Cartcount.dart';
// class AddToCartWidget extends StatefulWidget{
//   final String cartcountvalue;
//   AddToCartWidget({Key key, this.cartcountvalue})
//       : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return AddToCartstate();
//   }
// }
// class AddToCartstate extends State<AddToCartWidget>{
//
//   String  cartcounts;
//    getcount() async {
//     SharedPreferences Preferences = await SharedPreferences.getInstance();
//     setState(() {
//
//       cartcounts = Preferences.getString('cartcount');
//       print("value token addd part $cartcounts");
//
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     getcount();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     var providerType = Provider.of<CartModel>(context);
//
//    cartcounts=widget.cartcountvalue;
//    print(cartcounts);
//    return ChangeNotifierProvider<CartModel>( //      <--- ChangeNotifierProvider
//      create: (context) => CartModel(),
//      child:
//      Stack(
//        children: <Widget>[
//          new IconButton(icon: new Icon(Icons.shopping_cart,
//            color: Colors.white,),
//            onPressed: null,
//          ),
//          cartcounts==0 ? new Container() :
//          new Positioned(
//
//              child: new Stack(
//                children: <Widget>[
//                  new Icon(
//                      Icons.brightness_1,
//                      size: 20.0, color: Colors.red[800]),
//                  new Positioned(
//                      top: 3.0,
//                      right: 4.0,
//                      child: new Center(
//                        child:  Consumer<CartModel>( //                    <--- Consumer
//                          builder: (context, myModel, child) {
//                            return Text(cartcounts.toString(), style: new TextStyle(
//                                color: Colors.white,
//                                fontSize: 11.0,
//                                fontWeight: FontWeight.w500
//                            ),);
//                          },
//                        ),
//                        // new Text(
//                        // CartModel. ,
//                        //   style: new TextStyle(
//                        //       color: Colors.white,
//                        //       fontSize: 11.0,
//                        //       fontWeight: FontWeight.w500
//                        //   ),
//                        // ),
//                      )),
//                ],
//              )),
//
//        ],
//      )
//    );
//   }
//
//
//
// }