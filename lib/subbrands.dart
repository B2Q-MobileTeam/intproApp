import 'package:flutter/material.dart';

import 'addtocart.dart';
import 'listofbrands.dart';


//
// class Subbrand extends StatelessWidget {
//   const Subbrand(this.listbrand);
//   @required
//   final Listband listbrand;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Card(
//           clipBehavior: Clip.hardEdge,
//           elevation: 10.0,
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text(
//                   listbrand.brandname,
//                   textAlign: TextAlign.start,
//                 ),
//                 trailing:
//                 IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
//               )
//             ],
//           ),
//         )
//     );
//   }
// }
class UserTile extends StatelessWidget {
  final User user;

  UserTile({this.user});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(

            title: Text('${user.brandname}'),
            subtitle: Text(user.title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cart(
                          carttid:user.id,
                        title:user.title
                      )));


              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => UserDetailsPage(user: user)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}