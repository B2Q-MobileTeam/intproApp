import 'package:flutter/material.dart';

import 'brands.dart';


class Secbrand extends StatelessWidget {
  const Secbrand(this.brandss);
  @required
  final Brandss brandss;

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
                  brandss.brandsname,
                  textAlign: TextAlign.start,
                ),
                trailing:
                IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
              )
            ],
          ),
        ));
  }

// const Secbrand(this.brandss);
// @required
// final Brandss brandss;
// @override
// Widget build(BuildContext context) {
//   return Center(
//       child: Card(
//     clipBehavior: Clip.hardEdge,
//     elevation: 10.0,
//     child: Column(
//       children: [
//         ListTile(
//           title: Text(
//             brandss.brandsname,
//             textAlign: TextAlign.start,
//           ),
//           trailing:
//               IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
//         )
//       ],
//     ),
//   ));
// }
}
