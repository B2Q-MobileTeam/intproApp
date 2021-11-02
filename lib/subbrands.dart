import 'package:flutter/material.dart';

import 'addtocart.dart';
import 'brands.dart';
import 'listofbrands.dart';

class UserTile extends StatelessWidget {
  final User user;

  UserTile({this.user});



  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 10.0,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  user.brandnames,
                  textAlign: TextAlign.start,
                ),
                trailing:
                IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
                onTap: (){
    if (user.title == "plywoods") {
                  Navigator.push(
context,
MaterialPageRoute(
builder: (context) => Cart(
carttid:user.id,
title:user.title,
  b_name:user.brandnames
)));}else{
      Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Brands(
                                                    brandid:
                                                    user.id,
                                                    brandname:user.brandnames)));
    }
                },
              )
            ],
          ),
        )
    );
  }
}

