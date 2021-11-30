import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'NoInternet.dart';
import 'Url.dart';
import 'connectivity_provider.dart';
import 'drawer.dart';
import 'order_detail.dart';
class ResetPassword extends StatefulWidget {

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();
  void clear_reset_values() {
    new_pass.clear();
    con_new_pass.clear();
  }
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
  }
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

  TextEditingController new_pass = new TextEditingController();
  TextEditingController con_new_pass = new TextEditingController();
  void changepassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String mobileno_pay = (prefs.getString('mobileno'));
    print('mobileno $mobileno_pay');
    String Change_pass = new_pass.text;

    print('get mobnumber $Change_pass $mobileno_pay');
    print('get ${ApiCall.ChangePassword}');
    var response = await http.post(
        Uri.parse(ApiCall.ChangePassword),
        body: {
          "mobileno":mobileno_pay,
          "password": Change_pass,
        });
    var data = jsonDecode(response.body);
var resres = response.body;
print('res res $resres');
    var value = data['success'];
    print('value $value');

    if (value == 1) {
      print('yes');
      Fluttertoast.showToast(
          msg: "Password Changed Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.green[300],
          fontSize: 16.0);
      clear_reset_values();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {

      print('no');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context,model,child){
        if(model.isOnline!=null){
          return model.isOnline?
          SafeArea(child:
          Scaffold(
              appBar:  AppBar(
                elevation: 0.0,
                title: Text('Reset Password',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 22.0,
                        color: Colors.white)),
                centerTitle: true,
              ),
              drawer: Drawer_main(),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: [
                        Center(
                            child:
                            Image.asset('assets/passreset.png',
                              height:MediaQuery.of(context).size.height/3,
                              alignment: Alignment.center,
                            )
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20),
                            child:Text("Create new password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            autovalidate: false,
                            validator: (val) =>
                            val.length < 6 ? 'Enter a password 6+ chars long' : null,
                            controller: new_pass,
                            keyboardType: TextInputType.text,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              labelText: "New Password",
                              suffixIcon: GestureDetector(
                                  onTap: _toggle,
                                  child: Icon(_obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            ),
                            // onSaved: (password) => _password = password,
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(left:10,right: 10),
                          child:TextFormField(
                            autovalidate: false,
                            validator: (val) {
                              if (val.isEmpty) return 'Enter the  correct password';
                              if (val != new_pass.text) return 'Password is not match';
                            },
                            controller: con_new_pass,
                            keyboardType: TextInputType.text,
                            obscureText: _obsecure,
                            decoration: InputDecoration(
                              border:OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              labelText: "Confirm Password",
                              suffixIcon: GestureDetector(
                                  onTap: _toggle1,
                                  child: Icon(_obsecure
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                            height: 70,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                ),
                                onPressed: (){
                                  setState(() {
                                    if (_formKey.currentState.validate()) {
                                     print("checked");
                                     changepassword();
                                    }
                                  });
                                },
                                child: Text("Submit",style: TextStyle(fontSize: 18),),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
              )
          ))
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


  }


}
