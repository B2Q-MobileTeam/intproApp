import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

import '../addtocart.dart';
import '../brands.dart';
import '../listofbrands.dart';
import '../subbrands.dart';


class Listbrands1 extends StatefulWidget {
  final String indexvalue, catname, brandnamee;
  Listbrands1({ Key key,  this.indexvalue,  this.catname,  this.brandnamee})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Listbrandds1();
  }
}

class Listbrandds1 extends State<Listbrands1> {
   String catename;
   String brandename;


   Future<List<Listband>> _course;
  void initState() {

    setState(() {

      _course = fetchStudent();
    });
    super.initState();
  }

  Future<List<Listband>> fetchStudent() async {
    var url = 'https://www.binary2quantumsolutions.com/intpro/brands.php';
    print('brand $url');
    print('iddd ${widget.indexvalue}');
    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'cid': widget.indexvalue,
      },
    );

    var resJson = json.decode(response.body);
    print('object $resJson');
    final items = resJson['brand_list'].cast<Map<String, dynamic>>();
    return items.map<Listband>((j) => Listband.fromJson(j)).toList();
  }

  @override
  Widget build(BuildContext context) {
    catename = widget.catname;
    brandename = widget.brandnamee;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg1.jpg"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      fit: BoxFit.cover,
                    )),
                child: FutureBuilder<List<Listband>>(
                    future: _course,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                            //child: CircularProgressIndicator()
                        );
                      return Container(
                          padding: EdgeInsets.all(10.0),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    child: Subbrand(snapshot.data[index]),
                                    onTap: () {
                                      if (snapshot.data[index].title == "plywoods") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Cart(
                                                    carttid: snapshot
                                                        .data[index].id,
                                                    title:snapshot.data[index].title
                                                )));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Brands(
                                                    brandid:
                                                    snapshot.data[index].id,
                                                    brandname: snapshot
                                                        .data[index]
                                                        .brandname)));
                                      }
                                    });
                              }));
                    }))));
  }
}
