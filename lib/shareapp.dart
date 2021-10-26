import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import 'drawer.dart';
class ShareApp extends StatefulWidget {

  @override
  _ShareAppState createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  shares(BuildContext context)  {
    FlutterShare.share(
        title: 'Share our app',
        text: 'Share the App',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {
shares(context);
  }

  var cartcount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        elevation: 0.0,
        title: Text('Prohfjhfhjducts',
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
