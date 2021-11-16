import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';
import 'connectivity_provider.dart';
import 'dashboard.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyIntproApp());

}


class MyIntproApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create:
          (context)=>ConnectivityProvider(),
      )
    ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Intpro',
          home:  MyCustomSplashScreen(),
        ));
  }
}



class MyCustomSplashScreen extends StatefulWidget {
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 5.0;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  var token;

   AnimationController _controller;
   Animation<double> animation1;
  void getUserId()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('token');
    print("token $token");
  }
  @override
  void initState() {
    super.initState();
  getUserId();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
setState(() {
  print('token print $token');
  token == null ? Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder:
          (context) => Login(),
      ),(route) => false,
  ): Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder:
          (context) => Homee()
      ),(route) => false,
  );

});
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Color(0xffe8490d),
      body:Container(
        decoration: BoxDecoration(
         color: Colors.white
        ),
        child:  Stack(
          children: [
            Column(
              children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: _height / _fontSize
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: _textOpacity,
                  child: Text(
                    'Intpro',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: animation1.value,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 3000),
                curve: Curves.fastLinearToSlowEaseIn,
                opacity: _containerOpacity,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width / _containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  // child: Image.asset('assets/images/file_name.png')
                  child:Image.asset("assets/logo1.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validatepage()async {
    print("yes me wsdsgf rgsfgdf");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('token');
  print("token $token");


}


}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}


