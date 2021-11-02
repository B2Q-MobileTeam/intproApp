import 'dart:convert';

import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intpro_app/Url.dart';

import 'dashboard.dart';
import 'main.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return signupnext();
  }
}

class signupnext extends State<Signup> {
  bool _obscure = true;
  bool _obsecure = true;
  void _toggle() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  void _toggle1() {
    setState(() {
      _obsecure = !_obsecure;
    });
  }


  final _formKey = GlobalKey<FormState>();

  TextEditingController userrname = new TextEditingController();
  TextEditingController mobileno = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String phoneeNo, smssent, verificationId;

  get verifiedSuccess => null;

  void register() {
    String username = userrname.text;
    String mob = mobileno.text;
    String eemail = email.text;
    String pass = password.text;
    print('$username,$mob,$eemail,$pass');

    print('url ${ApiCall.RegisterUrl}');

    http.post(
        Uri.parse(ApiCall.RegisterUrl),
        body: {
      "name": username,
      "mobileno": mob,
      "email": eemail,
      "password": pass,
    }).then((res) {
      var resJson = json.decode(res.body);
      print('resjosn $resJson[success]');
      if (resJson['success'] == 0) {
        Fluttertoast.showToast(
            msg: "Mobile Number already register",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Registered Succesfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login3.jpg"), fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              children: [
                Center(
                    child: Image.asset(
                  'assets/logo1.png',
                  height: 180.0,
                  alignment: Alignment.center,
                )),
                TextFormField(
                  autovalidate: true,
                  validator: (val) => val.isEmpty ? 'Enter an Username' : null,
                  controller: userrname,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.supervised_user_circle),
                    hintText: "e.g Sampath",
                  ),
                  // onSaved: (name) => _username = name,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autovalidate: true,
                  validator: (val) =>
                      val.length < 10 ? 'Enter Min 10 Number' : null,
                  controller: mobileno,
                  autofocus: true,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Mobile No",
                    counterText: "",
                    prefixIcon: Icon(Icons.supervised_user_circle),
                  ),
                  // onSaved: (mobile) => _mob = mobile,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autovalidate: true,
                  validator: (val) => !EmailValidator.validate(val, true)
                      ? 'Enter an email'
                      : null,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline),
                    labelText: "Email",
                    hintText: "e.g abc@gmail.com",
                  ),
                  // onSaved: (email) => _email = email,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autovalidate: true,
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  controller: password,
                  keyboardType: TextInputType.text,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password",
                    suffixIcon: GestureDetector(
                        onTap: _toggle,
                        child: Icon(_obscure
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                  // onSaved: (password) => _password = password,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autovalidate: true,
                  validator: (val) {
                    if (val.isEmpty) return 'Enter the  correct password';
                    if (val != password.text) return 'Password is not match';
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _obsecure,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Confirm Password",
                    suffixIcon: GestureDetector(
                        onTap: _toggle1,
                        child: Icon(_obsecure
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                RaisedButton(
                  elevation: 5.0,
                  shape: StadiumBorder(),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    {
                      if (_formKey.currentState.validate()) {
                        register();
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 1,
      fontSize: 16.0);
}
