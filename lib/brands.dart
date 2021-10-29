// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
//
// import 'addtocart.dart';
//
// import 'secbrand.dart';
//
// class Brandss {
//   String cartsid;
//   String brandsname;
//
//   Brandss({this.cartsid, this.brandsname});
//   factory Brandss.fromJson(Map<String, dynamic> json) {
//     return Brandss(
//       cartsid: json['brand_id'],
//       brandsname: json['product_name'],
//     );
//   }
// }
//
// class Brands extends StatefulWidget {
//   final String brandid, brandname;
//   Brands({
//     Key key,
//     this.brandid,
//     this.brandname,
//   }) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return Subbrandss();
//   }
// }
//
// class Subbrandss extends State<Brands> {
//   String listname, brandname;
//   Future<List<Brandss>> _courses;
//   void initState() {
//     super.initState();
//     _courses = fetchbrand();
//   }
//
//   Future<List<Brandss>> fetchbrand() async {
//     var url = 'https://www.binary2quantumsolutions.com/intpro/products.php';
//     print('url $url');
//     var empty = widget.brandid;
//     print(' empty $empty');
//
//     final http.Response response = await http.post(
//       Uri.parse(url),
//       body: {
//         'brand_id': widget.brandid,
//       },
//     );
//
//     var resJson = json.decode(response.body);
//     print('object $resJson');
//     final items = resJson['brand_list'].cast<Map<String, dynamic>>();
//     return items.map<Brandss>((j) => Brandss.fromJson(j)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     listname = widget.brandid;
//     brandname = widget.brandname;
//
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             // appBar: AppBar(
//             //     centerTitle: true,
//             //     title: Text(brandname),
//             //     automaticallyImplyLeading: true,
//             //     leading: IconButton(
//             //       icon: Icon(Icons.arrow_back),
//             //       onPressed: () => Navigator.pop(context, false),
//             //     )),
//             body: Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/bg1.jpg"),
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(0.5), BlendMode.dstATop),
//                       fit: BoxFit.cover,
//                     )),
//                 child: FutureBuilder<List<Brandss>>(
//                     future: _courses,
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData)
//                         return Center(child: CircularProgressIndicator());
//                       return Container(
//                           padding: EdgeInsets.all(10.0),
//                           child: ListView.builder(
//                               itemCount: snapshot.data.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return GestureDetector(
//                                     child: Secbrand(snapshot.data[index]),
//                                     onTap: () => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => Cart(
//                                               cartid: snapshot.data[index].cartsid,
//                                             )))
//
//                                 );
//                               }));
//                     })
//             )));
//   }
// }





import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import 'drawer.dart';
import 'secbrand.dart';


class Brandss {
  String cartsid;
  String brandsname;
  String pro_id;
  String category_name;
  String product_name;

  Brandss({this.cartsid, this.brandsname,this.pro_id,this.category_name,this.product_name});
  factory Brandss.fromJson(Map<String, dynamic> json) {
    return Brandss(
      cartsid: json['brand_id'],
      brandsname: json['brandname'],
      pro_id: json['pro_id'],
      category_name: json['category_name'],
      product_name: json['product_name'],
    );
  }
}

class Brands extends StatefulWidget {
  final String brandid, brandname;
  Brands({
    Key key,
    this.brandid,
    this.brandname,
  }) : super(key: key);
  @override
  BrandsSubState createState() =>BrandsSubState();
}

class BrandsSubState extends State<Brands> {
  String catename;
  String brandename;
  List<Brandss> _brandss = <Brandss>[];
  List<Brandss> _brandssdisplay = <Brandss>[];
   String cartcount;
  bool _isLoading = true;
  String token;

    Future<List<Brandss>> fetchbrand() async {
    var url = 'https://www.binary2quantumsolutions.com/intpro/products.php';
    print('url $url');
    var empty = widget.brandid;
    print(' empty $empty');

    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'brand_id': widget.brandid,
      },
    );

    var resJson = json.decode(response.body);
    print('object $resJson');
    final items = resJson['brand_list'].cast<Map<String, dynamic>>();
    return items.map<Brandss>((j) => Brandss.fromJson(j)).toList();
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
    });
    fetchbrand().then((value) {
      setState(() {
        _isLoading = false;
        _brandss.addAll(value);
        _brandssdisplay = _brandss;
        print(_brandssdisplay.length);
      });
    });
    print('item cart 3');

    print('items count $cartcount');
  }
  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
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
        ),
        drawer: Drawer_main(),
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
                  return index == 0 ? _searchBar() : Secbrand(brandd: this._brandssdisplay[index - 1]);
                } else {
                  return LoadingView();
                }
              },
              itemCount: _brandssdisplay.length + 1,
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
              _brandssdisplay = _brandss.where((u) {
                var fName = u.brandsname.toLowerCase();

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