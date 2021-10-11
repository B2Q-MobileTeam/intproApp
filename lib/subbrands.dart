import 'package:flutter/material.dart';

import 'listofbrands.dart';



class Subbrand extends StatelessWidget {
  const Subbrand(this.listbrand);
  @required
  final Listband listbrand;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 10.0,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  listbrand.brandname,
                  textAlign: TextAlign.start,
                ),
                trailing:
                IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
              )
            ],
          ),
        )
    );
  }
}
