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
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashboardfragment.dart';
import 'brands.dart';
import 'drawer.dart';
import 'subbrands.dart';


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

class HomePageSub extends StatefulWidget {
  static const String routeName = '/productone';
    final String indexvalue, catname, brandnamee;
  HomePageSub({Key key, this.indexvalue, this.catname, this.brandnamee})
      : super(key: key);
  @override
  _HomePageSubState createState() => _HomePageSubState();
}

class _HomePageSubState extends State<HomePageSub> {
  String catename;
  String brandename;
  List<User> _users = <User>[];
  List<User> _usersDisplay = <User>[];
  var token;
var cartcount;
  bool _isLoading = true;

  Future<List<User>> fetchStudent() async {
    var url = 'https://www.binary2quantumsolutions.com/intpro/brands.php';
    print('brand $url');
    print('iddd ${widget.catname}');
    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'cid':widget.indexvalue,
      },
    );

    var resJson = json.decode(response.body);
    print('object $resJson');
    final items = resJson['brand_list'].cast<Map<String, dynamic>>();
    return items.map<User>((j) => User.fromJson(j)).toList();
  }

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
     token = preferences.getString('token');
      print("token $token");
      getcartdetail();
    });
  }

  Future getcartdetail() async {
    print("cart 2");
    var url = 'https://www.binary2quantumsolutions.com/intpro/cart_details.php';
    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'user_id': "80",
      },
    );

    var resJson = json.decode(response.body);
    print("cart data");
    print('object $resJson');
    final items = resJson['cart_details'];
    print('cartdetails $items');
    final itemsWithout = resJson['cart_details'];
    var cartcart = resJson['data'];
    print('items product $cartcart');
    setState(() {
      cartcount = cartcart;
      fetchStudent().then((value) {
        setState(() {
          _isLoading = false;
          _users.addAll(value);
          _usersDisplay = _users;
          print(_usersDisplay.length);
        });
      });
    });

    print('item cart 3');

    print('items count $cartcount');
  }
  @override
  void initState() {
    getEmail();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    String catproname=widget.catname;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Products',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontSize: 22.0, color: Colors.white)),
          actions: [
            Stack(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    print('cartcount $cartcount');
                  },
                ),
                cartcount == 0
                    ? new Container()
                    : new Positioned(
                    child: new Stack(
                      children: <Widget>[
                        new Icon(Icons.brightness_1,
                            size: 25.0, color: Colors.red[800]),
                        new Positioned(
                            top: 3.0,
                            right: 5.0,
                            child: new Center(
                              child: Text(
                                cartcount.toString(),
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )),
              ],
            ),
          ],
          centerTitle: true,
        ),
        drawer:Drawer_main(),
    body:
      Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg1.jpg"),
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.9),
                          BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )),
          child:Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            child:  ListView.builder(
              itemBuilder: (context, index) {
                if (!_isLoading) {
                  return index == 0 ? _searchBar() : UserTile(user: this._usersDisplay[index - 1]);
                } else {
                  return LoadingView();
                }
              },
              itemCount: _usersDisplay.length + 1,
            ),
          )
        ));


  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child:Card(
        child:  TextField(
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
            fillColor: Colors.white,
            border: OutlineInputBorder(

            ),
            prefixIcon: Icon(Icons.search),
            hintText: 'Search Products',
          ),
        ),
      ),
    );
  }
}


class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.green,
      ),
    );
  }
}

