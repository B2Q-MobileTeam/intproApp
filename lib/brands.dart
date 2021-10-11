import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'addtocart.dart';

import 'secbrand.dart';

class Brandss {
  String cartsid;
  String brandsname;

  Brandss({this.cartsid, this.brandsname});
  factory Brandss.fromJson(Map<String, dynamic> json) {
    return Brandss(
      cartsid: json['brand_id'],
      brandsname: json['product_name'],
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
  State<StatefulWidget> createState() {
    return Subbrandss();
  }
}

class Subbrandss extends State<Brands> {
  String listname, brandname;
  Future<List<Brandss>> _courses;
  void initState() {
    super.initState();
    _courses = fetchbrand();
  }

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

  @override
  Widget build(BuildContext context) {
    listname = widget.brandid;
    brandname = widget.brandname;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // appBar: AppBar(
            //     centerTitle: true,
            //     title: Text(brandname),
            //     automaticallyImplyLeading: true,
            //     leading: IconButton(
            //       icon: Icon(Icons.arrow_back),
            //       onPressed: () => Navigator.pop(context, false),
            //     )),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg1.jpg"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )),
                child: FutureBuilder<List<Brandss>>(
                    future: _courses,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      return Container(
                          padding: EdgeInsets.all(10.0),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    child: Secbrand(snapshot.data[index]),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Cart(
                                              cartid: snapshot.data[index].cartsid,
                                            )))

                                );
                              }));
                    })
            )));
  }
}
