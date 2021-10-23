import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class tokendata{
Future getEmail() async {
String token;
SharedPreferences preferences = await SharedPreferences.getInstance();
token = preferences.getString('token');
print("value token $token");

return token;
}
}