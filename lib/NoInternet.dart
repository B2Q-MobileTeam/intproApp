import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Url.dart';

class NoInternet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
    body:Container(
      color: Colors.white,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top:20),
            child: Image.network(ApiCall.logo1,),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/Noconnection.png"),
            //       colorFilter: ColorFilter.mode(
            //           Colors.white.withOpacity(0.8), BlendMode.dstATop),
            //
            //     )),
            height: MediaQuery
                .of(context)
                .size
                .height/1.5,
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
          Text("No Internet Connection ",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.w500),),
          Text("Please check your internet connection.",style: TextStyle(color: Colors.black87,fontSize: 15,
              fontWeight: FontWeight.w400),),
        ],
      ),
    ))
    );
  }
}
