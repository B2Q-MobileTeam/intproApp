

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intpro_final/Dashboardfragment.dart';
import 'package:intpro_final/order_detail.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'frgt.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('token');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
     //  home:DashboardFragment()
  // home: token == null ? Login() : Homee()
   home: token == null ? Login() : DashboardFragment()
  ));
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginext();
  }
}

class loginext extends State<Login> {
  bool _obscureText = true;
  bool _autovalidate = false;

  String _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController mob = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  void login() async {
    String mobile = mob.text;
    String password = pass.text;

//    var url = 'http://192.168.0.107/Intpro/login.php';
    var url = 'https://www.binary2quantumsolutions.com/intpro/Login.php';
    print('get $url');

    var response = await http.post(
        Uri.parse(url),
        body: {
      "mobileno": mobile,
      "password": password,
    });
    var data = json.decode(response.body);
    print('login data $data');
    print(response);
    var id = data['id'];  
    var name = data['name1'];
    var mobileno = data['mobileno'];
    var email = data['email'];

    print('id $id');

    var succ = data['success'];
    print('succ $succ');
    if (succ == 0) {
      Fluttertoast.showToast(
          msg: "Invalid Username and Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          fontSize: 16.0);
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('token', id);
      preferences.setString('name1', name);
      preferences.setString('mobileno', mobileno);
      preferences.setString('email', email);
      print('preference $preferences');
      Fluttertoast.showToast(
          msg: "Login Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardFragment()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue[50],

      // appBar: AppBar(
      //   title: Text("IntPro"),
      //   centerTitle: true,
      // ),
        body: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login3.jpg"), fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                    child: Image.asset(
                      'assets/logo1.png',
                      height: 180.0,
                      alignment: Alignment.center,
                    )),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  autovalidate: _autovalidate,
                  validator: (val) =>
                  val.length < 10 ? 'Enter Valid  Number' : null,
                  controller: mob,
                  autofocus: true,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.yellow)),
                    labelText: "Mobile No",
                    labelStyle: TextStyle(color: Colors.black),
                    counterText: "",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  // onSaved: (mobile) => _mob = mobile,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autovalidate: _autovalidate,
                  validator: (val) => val.length < 6 ? 'Enter a password' : null,
                  controller: pass,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.yellow)),
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    suffixIcon: GestureDetector(
                        onTap: _toggle,
                        child: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                  // onSaved: (password) => _password = password,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Forgot()));
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: 50.0,
                      right: 50.0,
                    ),
                    child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Reference ID',
                            hintStyle: TextStyle(
                              color: Colors.blueAccent,
                            )))),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'eg : 9159028571',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    child: RaisedButton(
                      elevation: 5.0,
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                           setState(() => _isLoading = true);
                          login();
                        }
                      },
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  Text('Already Have an Account ?'),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text('SignUp',
                          style: TextStyle(color: Colors.blue, fontSize: 18.0))),
                ]),
              ],
            ),
          ),
        ));
  }
}
