
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intpro_final/Dashboardfragment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addtocart.dart';
import 'cell.dart';
import 'listofbrands.dart';


import 'main.dart';
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
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: JsonImageList(),
      ),
    ),
  );
}}

Future logOut(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('token');
  Fluttertoast.showToast(
      msg: "Logout Successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.amber,
      textColor: Colors.white,
      fontSize: 16.0);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Login(),
    ),
  );
}



 share(BuildContext context)  {
     FlutterShare.share(
        title: 'Share our app',
        text: 'Share the App',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
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

  String token = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
    });
  }

  Future logOut(BuildContext context) async {}
  @override
  void initState() {
    super.initState();
    getEmail();

  }

  final String apiURL =
      'https://www.binary2quantumsolutions.com/intpro/category.php';

  Future<List<Flowerdata>> fetchFlowers() async {
    var response = await http.get(Uri.parse(apiURL));
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
    return FutureBuilder<List<Flowerdata>>(
        future: fetchFlowers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              // child: SpinKitCircle(
              //   color: Colors.blueAccent,
              //   size: 50.0,
              // ),
            );
          return new Padding(
              padding: new EdgeInsets.all(10.0),
              child: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                        child: Cell(snapshot.data[index]),
                        onTap: () =>
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Listbrands(
                                    indexvalue: snapshot.data[index].cid,
                                    catname: snapshot.data[index].title,
                                    brandnamee:
                                    snapshot.data[index].catergoryname)))
                    );
                  }));
        });
  }
}

