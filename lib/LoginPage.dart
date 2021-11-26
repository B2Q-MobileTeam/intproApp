import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intpro_app/Url.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'NoInternet.dart';
import 'connectivity_provider.dart';
import 'dashboard.dart';
import 'frgt.dart';

import 'register.dart';
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

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();

  }


  void cleardatalogin() {
    mob.clear();
    pass.clear();
  }
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController mob = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  void login() async {
    String mobile = mob.text;
    String password = pass.text;

    print('get ${ApiCall.LoginUrl}');

    var response = await http.post(
        Uri.parse(ApiCall.LoginUrl),
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
     cleardatalogin ();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Homee()),(route) => false,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<ConnectivityProvider>(
        builder: (context, model, child) {
          if (model.isOnline != null) {
            return model.isOnline ?
            SafeArea(
              child: Scaffold(
                  body: Container(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/login3.jpg"),
                            fit: BoxFit.cover)),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Center(
                              child: Image.network(ApiCall.logo1,
                                height: 180.0,
                                alignment: Alignment.center,)
                            // Image.asset(
                            //   'assets/logo1.png',
                            //   height: 180.0,
                            //   alignment: Alignment.center,
                            // )
                          ),
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
                                  borderSide: new BorderSide(
                                      color: Colors.yellow)),
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
                            validator: (val) =>
                            val.length < 6
                                ? 'Enter a password'
                                : null,
                            controller: pass,
                            keyboardType: TextInputType.text,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.yellow)),
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
                         Padding(
                           padding: EdgeInsets.only(top: 10),
                           child: Align(
                             alignment: Alignment.topRight,
                             child: InkWell(
                               onTap: () {
                                 print('forget password');
                                 showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       return ForgetPassword();
                                     });
                                 // Navigator.pushReplacement(
                                 //     context,
                                 //     MaterialPageRoute(
                                 //         builder: (BuildContext context) =>
                                 //             Forgot()
                                 //     )
                                 // );
                               },
                               child: Text(
                                 'Forgot Password ?',
                                 style: TextStyle(color: Colors.blue),
                               ),
                             ),
                           ),
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
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Already Have an Account ?'),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) => Signup()));
                                    },
                                    child: Text('SignUp',
                                        style: TextStyle(color: Colors.blue,
                                            fontSize: 18.0))),
                              ]),
                        ],
                      ),
                    ),
                  )),
            )
                :
            NoInternet();
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
  }}

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 40,
                      child: Image.asset("assets/frgtimg.jpeg"),
                    ),
                    Text('Forget Password !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.redAccent,
                        ),
                        child: TextFormField(



                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide:
                                BorderSide(color: Colors.red)),
                            labelText: 'Mobile Number',
                            prefixIcon: Icon(
                              Icons.phone_android_sharp,
                              color: Colors.red,
                            ),
                            hintText: "9876543212",
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          autofocus: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                      color: Colors.redAccent,
                      child: Text('Submit', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
            // Positioned(
            //     top: -60,
            //     child: CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       radius: 60,
            //       child: Icon(Icons.vpn_key, color: Colors.white, size: 50,),
            //     )
            // ),
          ],
        )
    );
  }
}



