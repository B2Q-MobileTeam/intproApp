import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intpro_app/Url.dart';
import 'package:intpro_app/model/myorderlist.dart';
import 'Dashboardfragment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addtocart.dart';
import 'cell.dart';
import 'drawer.dart';
import 'listofbrands.dart';

import 'main.dart';
import 'order_detail.dart';
import 'rate.dart';

class Homee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/login3.jpg"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
            fit: BoxFit.cover,
          )),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: JsonImageList(),
        ),
      ),
    );
  }
}



class Flowerdata {
  int id;
  String catergoryname;
  String flowerImageURL;
  String cid;
  String title;

  Flowerdata(
      {this.id, this.cid, this.catergoryname, this.title, this.flowerImageURL});

  factory Flowerdata.fromJson(Map<String, dynamic> json) {
    return Flowerdata(
        id: json['id'],
        cid: json['cid'],
        catergoryname: json['category_name'],
        flowerImageURL: json['cat_img'],
        title: json['title']);
  }
}

class JsonImageList extends StatefulWidget {
  JsonImageListWidget createState() => JsonImageListWidget();
}

class JsonImageListWidget extends State {
  String cartcount="0";
  String token ="";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("token $token");
      getcartdetail();
    });
  }

  Future getcartdetail() async {
    print("cart");
   // var url = 'https://www.binary2quantumsolutions.com/intpro/cart_details.php';
    final http.Response response = await http.post(
      Uri.parse(ApiCall.CartDetails),
      body: {
        'user_id':token
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
   setState((){
     cartcount = cartcart;

   });
    print('item cart 3');

    print('items count $cartcount');
  }

  Future logOut(BuildContext context) async {}

  @override
  void initState() {

      getEmail();
      getcartdetail();

    super.initState();
  }



  Future<List<Flowerdata>> fetchFlowers() async {
    var response = await http.get(Uri.parse(ApiCall.CategoryOfProducts));
    print('object $response');

    if (response.statusCode == 200) {
      var hello = json.decode(response.body);
      print("urldata $hello");
      final items = hello['category_data'].cast<Map<String, dynamic>>();

      List<Flowerdata> listOfFruits = items.map<Flowerdata>((json) {
        return Flowerdata.fromJson(json);
      }).toList();

      return listOfFruits;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  selectedItem(BuildContext context, String holder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(holder),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                        ),
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
        drawer: Drawer_main(),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login3.jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstATop),
                fit: BoxFit.cover,
              )),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<Flowerdata>>(
              future: fetchFlowers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(

                  );
                return new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate:
                        new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return new GestureDetector(
                              child: Cell(snapshot.data[index]),
                              onTap: () =>

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageSub(
                                          indexvalue:
                                          snapshot.data[index].cid,
                                          catname: snapshot.data[index].title,
                                          brandnamee: snapshot
                                              .data[index].catergoryname))));
                        }));
              }),

      ),
    );
  }
}
