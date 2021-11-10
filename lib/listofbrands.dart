
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Url.dart';
import 'brands.dart';
import 'drawer.dart';
import 'order_detail.dart';
import 'subbrands.dart';


class User {
  String id;
  String brandnames;
  String title;

  User({this.id, this.brandnames,this.title});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], brandnames: json['brandname'], title: json['title']);
  }
}

class HomePageSub extends StatefulWidget {

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
var cartcount="0";
  bool _isLoading = true;

  Future<List<User>> fetchStudent() async {

    print('brand ${ApiCall.BrandsList}');
    print('iddd ${widget.catname}');
    final http.Response response = await http.post(
      Uri.parse(ApiCall.BrandsList),
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
    final http.Response response = await http.post(
      Uri.parse(ApiCall.CartDetails),
      body: {
        'user_id':token,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyOrder()
                        )
                    );
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
                var fName = u.brandnames.toLowerCase();

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
        color: Colors.blue,
      ),
    );
  }
}

