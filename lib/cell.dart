import 'package:flutter/material.dart';

import 'dashboard.dart';


class Cell extends StatelessWidget {
  const Cell(this.flowerdata);
  @required
  final Flowerdata flowerdata;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            child: Container(
                child: Card(
                  elevation: 10.0,
                  color: Colors.grey,
                  child: Card(
                    child: new Column(
                      children: <Widget>[
                        ListTile(
                            title: Image.network(flowerdata.flowerImageURL,
                                alignment: Alignment.center, fit: BoxFit.cover),
                            subtitle: Center(
                                child: Text(
                                  flowerdata.catergoryname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18.0),
                                )))
                      ],
                    ),
                  ),
                ))));
  }
}
