import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intpro_app/model/myorderlist.dart';
import 'package:intpro_app/order_detail.dart';
import 'package:intpro_app/routes.dart';
import 'package:intpro_app/tokenidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'main.dart';

// class Drawer_main extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//    Drawer_main_state();
//   }
//
// }
//
// class Drawer_main_state extends State<Drawer_main>{
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Material(
//         child: ListView(
//           children: [
//             Container(
//               child: Column(
//                 children: <Widget>[
//                   DrawerHeader(
//                       child: Container(
//                         height: 600,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 "assets/logo1.png",
//                               ),
//                             )),
//                       )),
//
//                 ],
//               ),
//             ),
//             ListTile(
//               selectedTileColor: Colors.grey[200],
//               leading: new Icon(Icons.person,),
//               title: new Text("Home",),
//               onTap: () {
//                 Navigator.pop(context);
//
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => Homee()
//                     )
//                 );
//                 // Navigator.pushNamed(context, Homee.routeName);
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.grey[200],
//               leading: new Icon(Icons.person,),
//               title: new Text("My Order",),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => MyOrder()
//                     )
//                 );
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.grey[200],
//               leading: new Icon(Icons.person,),
//               title: new Text("My Cart",),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => MyOrder()
//                     )
//                 );
//               },
//             ),
//           ],
//         ),
//       )
//
//   );
//   }
//
//
// }

class Drawer_main extends StatelessWidget {
      @override
  Widget build(BuildContext context) {

   return Drawer(
      child: Material(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/logo1.png",
                              ),
                            )),
                      )),

                ],
              ),
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.person,),
              title: new Text("Home",),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Homee()
                    )
                );
                // Navigator.pushNamed(context, Homee.routeName);
              },
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.drive_file_move_outline,),
              title: new Text("My Order",),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyOrderListprocess()
                    )
                );
              },
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.shopping_cart_outlined,),
              title: new Text("My Cart",),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyOrder()
                    )
                );
              },
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.share,),
              title: new Text("Share App",),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => ShareApp()
                //     )
                // );
              },
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.star,),
              title: new Text("Rate Us",),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => RateUs()
                //     )
                // );
              },
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.exit_to_app,),
              title: new Text("Logout",),
              onTap: ()async {

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

              },
            ),
          ],
        ),
      )

  );
  }

}

// createDrawer(BuildContext context)  {
//
//   return Drawer(
//       child: Material(
//         child: ListView(
//           children: [
//             Container(
//               child: Column(
//                 children: <Widget>[
//                   DrawerHeader(
//                       child: Container(
//                         height: 600,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 "assets/logo1.png",
//                               ),
//                             )),
//                       )),
//
//                 ],
//               ),
//             ),
//             ListTile(
//               selectedTileColor: Colors.grey[200],
//               leading: new Icon(Icons.person,),
//               title: new Text("Home",),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, Homee.routeName);
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.grey[200],
//               leading: new Icon(Icons.person,),
//               title: new Text("My Order",),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context,MyOrder.routeName);
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.grey[200],
//               leading: new Icon(Icons.person,),
//               title: new Text("My Cart",),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context,MyOrder.routeName);
//               },
//             ),
//           ],
//         ),
//       )
//
//   );
//
// }

//
//   Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           Container(
//             color: Theme.of(context).canvasColor,
//             child: DrawerHeader(
//               child: Text(
//                 'Navigation Drawer',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//           ListTile(
//               leading: Icon(Icons.monetization_on),
//               title: Text('New Transaction'),
//               onTap: () {
//                 Navigator.pushReplacementNamed(context,routes.transaction);
//               }),
//           ListTile(
//               leading: Icon(Icons.category),
//               title: Text('Categories Manager'),
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, routes.categories);
//               }),
//         ],
//       ));
// }