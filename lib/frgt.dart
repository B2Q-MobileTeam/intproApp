import 'dart:convert';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'LoginPage.dart';
import 'NoInternet.dart';
import 'Url.dart';
import 'connectivity_provider.dart';
import 'main.dart';


class Forgot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Forgotte();
  }
}

class Forgotte extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();

  void chck() async {
    String eemail = email.text;


    print('get ${ApiCall.ForgetPassword}');
    var response = await http.post(
        Uri.parse(ApiCall.ForgetPassword),
        body: {
      "email_id": eemail,
    });
    var data = jsonDecode(response.body);

    var value = data['success'];
    print('value $value');

    if (value == true) {
      print('yes');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      print('no');
    }
  }

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
  }

  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context,model,child){
        if(model.isOnline!=null){
          return model.isOnline?
          MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  appBar: PreferredSize(
                    child: AppBar(
                      backgroundColor: Colors.black,
                    ),
                    preferredSize: Size.fromHeight(10.0),
                  ),
                  body: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          size: 40.0,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Login()));
                                        })
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Text('Forgot Password ?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0)),
                                      ],
                                    )),
                                Container(
                                  child: Image.network(ApiCall.forgetpw,
                                  height: 150,)
                                  // Image.asset(
                                  //   'assets/frgt.png',
                                  //   height: 150.0,
                                  // ),
                                ),
                                SizedBox(
                                  height: 100.0,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      primaryColor: Colors.redAccent,
                                    ),
                                    child: TextFormField(
                                      controller: email,
                                      autovalidate: _autovalidate,
                                      validator: (val) =>
                                      !EmailValidator.validate(val, true)
                                          ? 'Enter an email'
                                          : null,
                                      keyboardType: TextInputType.emailAddress,
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
                                        labelText: 'Email',
                                        prefixIcon: Icon(
                                          Icons.mail_outline,
                                          color: Colors.red,
                                        ),
                                        hintText: "e.g abc@gmail.com",
                                        labelStyle: TextStyle(color: Colors.black),
                                      ),
                                      autofocus: true,
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Text(
                                      'Reset your password with email',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                      textAlign: TextAlign.right,
                                    )),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  height: 50.0,
                                  child: RaisedButton(
                                    elevation: 2.0,
                                    onPressed: () {
                                      chck();
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    padding: EdgeInsets.all(2.5),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 300.0,
                                            minHeight: double.infinity),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "SUBMIT",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ))))
              :NoInternet();
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
