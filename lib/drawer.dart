import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intpro_app/LoginPage.dart';
import 'package:intpro_app/model/myorderlist.dart';
import 'package:intpro_app/order_detail.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';

import 'ResetPassword.dart';
import 'Url.dart';
import 'dashboard.dart';
import 'main.dart';
import 'rate.dart';
import 'shareapp.dart';



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
                        child: Image.network(ApiCall.logo1),
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: AssetImage(
                        //         "assets/logo1.png",
                        //       ),
                        //     )),

                      )
                  ),

                ],
              ),
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.person,),
              title: new Text("Home",),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Homee()
                    ),(route) => false,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ShareApp()
                    )
                );
              },
            ),

            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.star,),
              title: new Text("Rate Us",),
              onTap: () {
                Navigator.pop(context);
                StoreRedirect.redirect(
                  androidAppId: 'com.intpro.intpro_app',
                  iOSAppId: '',
                );
              },
            ),
            ListTile(
              selectedTileColor: Colors.grey[200],
              leading: new Icon(Icons.lock,),
              title: new Text("Change Password",),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ResetPassword()
                    )
                );
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),(route) => false,
                  );

              },
            ),
          ],
        ),
      )


  );
  }

}
