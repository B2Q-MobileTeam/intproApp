// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/widgets.dart';
//
// import 'package:flutter/material.dart';
//
//
// import 'addtocart.dart';
// import 'brands.dart';
// import 'subbrands.dart';
//
// class Listband {
//   String id;
//   String brandname;
//   String title;
//
//   Listband({this.id, this.brandname,this.title});
//   factory Listband.fromJson(Map<String, dynamic> json) {
//     return Listband(
//         id: json['id'], brandname: json['brandname'], title: json['title']);
//   }
// }
//
// class Listbrands extends StatefulWidget {
//   final String indexvalue, catname, brandnamee;
//   Listbrands({Key key, this.indexvalue, this.catname, this.brandnamee})
//       : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return Listbrandds();
//   }
// }
//
// class Listbrandds extends State<Listbrands> {
//   String catename;
//   String brandename;
//
//
//   Future<List<Listband>> _course;
//   void initState() {
//
//     setState(() {
//
//       _course = fetchStudent();
//     });
//     super.initState();
//   }
//
//   Future<List<Listband>> fetchStudent() async {
//     var url = 'https://www.binary2quantumsolutions.com/intpro/brands.php';
//     print('brand $url');
//     print('iddd ${widget.indexvalue}');
//     final http.Response response = await http.post(
//       Uri.parse(url),
//       body: {
//         'cid': widget.indexvalue,
//       },
//     );
//
//     var resJson = json.decode(response.body);
//     print('object $resJson');
//     final items = resJson['brand_list'].cast<Map<String, dynamic>>();
//     return items.map<Listband>((j) => Listband.fromJson(j)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     catename = widget.catname;
//     brandename = widget.brandnamee;
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//
//             body: Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/bg1.jpg"),
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(0.5), BlendMode.dstATop),
//                       fit: BoxFit.cover,
//                     )),
//                 child: FutureBuilder<List<Listband>>(
//                     future: _course,
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData)
//                         return Center(child: CircularProgressIndicator());
//                       return Container(
//                           padding: EdgeInsets.all(10.0),
//                           child: ListView.builder(
//                               itemCount: snapshot.data.length,
//                               itemBuilder: (context, index) {
//                                 return GestureDetector(
//                                     child: Subbrand(snapshot.data[index]),
//                                     onTap: () {
//                                       if (snapshot.data[index].title == "plywoods") {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => Cart(
//                                                     carttid: snapshot
//                                                         .data[index].id,
//                                                     title:snapshot.data[index].title
//                                                 )));
//                                       } else {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) => Brands(
//                                                     brandid:
//                                                     snapshot.data[index].id,
//                                                     brandname: snapshot
//                                                         .data[index]
//                                                         .brandname)));
//                                       }
//                                     });
//                               }));
//                     })
//             )
//         )
//     );
//   }
// }




//
// ///search process//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/widgets.dart';
//
// import 'package:flutter/material.dart';
//
//
// import 'addtocart.dart';
// import 'brands.dart';
// import 'subbrands.dart';
//
// class Listband {
//   String id;
//   String brandname;
//   String title;
//
//   Listband({this.id, this.brandname,this.title});
//   factory Listband.fromJson(Map<String, dynamic> json) {
//     return Listband(
//         id: json['id'], brandname: json['brandname'], title: json['title']);
//   }
// }
//
// class Listbrands extends StatefulWidget {
//   final String indexvalue, catname, brandnamee;
//   Listbrands({Key key, this.indexvalue, this.catname, this.brandnamee})
//       : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return Listbrandds();
//   }
// }
//
// class Listbrandds extends State<Listbrands> {
//   String catename;
//   String brandename;
//   List<Listband> products = <Listband>[];
//   List<Listband> filterproducts = <Listband>[];
//   bool _isLoading = true;
//   var items;
//
//   ////search
//   TextEditingController _textController = TextEditingController();
//   List<Map<String, dynamic>> _foundUsers = [];
//   final List<Map<String, dynamic>> _allUsers=[];
//
//   Future<List<Listband>> _course;
//   void initState() {
//
//     setState(() {
//
//       _course = fetchStudent();
//
//     });
//     super.initState();
//   }
//
//
//
//   Future<List<Listband>> fetchStudent() async {
//     var url = 'https://www.binary2quantumsolutions.com/intpro/brands.php';
//     print('brand $url');
//     print('iddd ${widget.indexvalue}');
//     final http.Response response = await http.post(
//       Uri.parse(url),
//       body: {
//         'cid': widget.indexvalue,
//       },
//     );
//
//     var resJson = json.decode(response.body);
//     print('object $resJson');
//     items = resJson['brand_list'].cast<Map<String, dynamic>>();
//     var products=items.map<Listband>((j) => Listband.fromJson(j)).toList();
//     print("heloo $items");
//     filterproducts=products;
//     return products;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     catename = widget.catname;
//     brandename = widget.brandnamee;
//     return
//       Container(decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/bg1.jpg"),
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(0.5),
//                           BlendMode.dstATop),
//                       fit: BoxFit.cover,
//                     )),
//             padding: EdgeInsets.only(top:10),
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField()
//
//               ],
//             ),
//           );
//
//
//   }
//
//   // _searchBar() {
//   //   return Padding(
//   //     padding: EdgeInsets.all(12.0),
//   //     child: TextField(
//   //       autofocus: false,
//   //       onChanged: (searchText) {
//   //         searchText = searchText.toLowerCase();
//   //         setState(() {
//   //           _usersDisplay = _users.where((u) {
//   //             var fName = u.brandname.toLowerCase();
//   //
//   //             return fName.contains(searchText);
//   //           }).toList();
//   //         });
//   //       },
//   //       // controller: _textController,
//   //       decoration: InputDecoration(
//   //         border: OutlineInputBorder(),
//   //         prefixIcon: Icon(Icons.search),
//   //         hintText: 'Search Users',
//   //       ),
//   //     ),
//   //   );
//   // }
// }



//
// FutureBuilder<List<Listband>>(
// future: _course,
// builder: (context, snapshot) {
// if (!snapshot.hasData)
// return Center(child: CircularProgressIndicator());
// return Container(
// padding: EdgeInsets.all(10.0),
// child: ListView.builder(
// itemCount:_usersDisplay.length+1,
// itemBuilder: (context, index) {
// if(!_isLoading){
// return index == 0?_searchBar():
// GestureDetector(
// child: Subbrand(snapshot.data[index-1]),
// onTap: () {
// if (snapshot.data[index].title == "plywoods") {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Cart(
// carttid: snapshot
//     .data[index].id,
// title:snapshot.data[index].title
// )));
// } else {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Brands(
// brandid:
// snapshot.data[index].id,
// brandname: snapshot
//     .data[index]
//     .brandname)));
// }
// });
//
// }else{
// return CircularProgressIndicator();
// }
// // GestureDetector(
// //   child: Subbrand(snapshot.data[index]),
// //   onTap: () {
// //     if (snapshot.data[index].title == "plywoods") {
// //       Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //               builder: (context) => Cart(
// //                   carttid: snapshot
// //                       .data[index].id,
// //                   title:snapshot.data[index].title
// //               )));
// //     } else {
// //       Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //               builder: (context) => Brands(
// //                   brandid:
// //                   snapshot.data[index].id,
// //                   brandname: snapshot
// //                       .data[index]
// //                       .brandname)));
// //     }
// //   });
// }));
// })



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intpro_final/brands.dart';
import 'package:intpro_final/subbrands.dart';

Future<List<User>> fetchStudent() async {
  var url = 'https://www.binary2quantumsolutions.com/intpro/brands.php';
  print('brand $url');
  //print('iddd ${widget.indexvalue}');
  final http.Response response = await http.post(
    Uri.parse(url),
    body: {
      'cid':"1",
    },
  );

  var resJson = json.decode(response.body);
  print('object $resJson');
  final items = resJson['brand_list'].cast<Map<String, dynamic>>();
  return items.map<User>((j) => User.fromJson(j)).toList();
}
class User {
  String id;
  String brandname;
  String title;

  User({this.id, this.brandname,this.title});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], brandname: json['brandname'], title: json['title']);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> _users = <User>[];
  List<User> _usersDisplay = <User>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudent().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        _usersDisplay = _users;
        print(_usersDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg1.jpg"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )),
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0 ? _searchBar() : UserTile(user: this._usersDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _usersDisplay.length + 1,
          ),
        ),
      );

  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _usersDisplay = _users.where((u) {
              var fName = u.brandname.toLowerCase();

              return fName.contains(searchText) ;
            }).toList();
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Users',
        ),
      ),
    );
  }
}


class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.2,
        ),

        Text('Loading ...',
          style: TextStyle(
            fontSize: 16.0,
          ),),
      ],
    );
  }
}