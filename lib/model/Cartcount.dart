import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:flutter/material.dart';


class CartModel with ChangeNotifier { //                          <--- MyModel
  String someValue="7";

  void doaddproduct() {
    someValue="";
    someValue = '44';
    print("someValue add to cart $someValue");
    notifyListeners();
  }

  void dodeleteproduct(){
    someValue = '42';
    print(someValue);
    notifyListeners();
  }
}