import 'package:flutter/material.dart';

import 'addtocart.dart';
import 'brands.dart';

class Secbrand extends StatelessWidget {
  final Brandss brandd;

  Secbrand({this.brandd});



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
                    brandd.product_name,
                    textAlign: TextAlign.start,
                  ),
                  trailing:
                  IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
                  onTap: (){
                    print('cartid ${brandd.cartsid}');
                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Cart(
                                              cartid: brandd.cartsid,
                                              pro_id:brandd.pro_id,
                                              pro_name:brandd.product_name,
                                              brand_name:brandd.brandsname,
                                              cat_name:brandd.category_name
                                            )));


                  },
                )
              ],
            ),
          )
      );
  }
}
