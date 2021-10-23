import 'package:flutter/material.dart';

Widget AppBarView(BuildContext context) {
  var cartcount;
  return AppBar(
    elevation: 0.0,
    title: Text('Products',
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 22.0,
            color: Colors.white)),
    actions: [
      Stack(
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.shopping_cart,
            color: Colors.white,),
            onPressed: () {

            },
          ),
          cartcount == 0 ? new Container() :
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
  );

}