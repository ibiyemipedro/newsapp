import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard.dart';

class SplashPage extends StatefulWidget {
  static String tag = 'SplashPage';
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  double screenWidth, screenHeight;
  final globalKey = new GlobalKey<ScaffoldState>();
//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    
    new Future.delayed(const Duration(seconds: 5), _handleTapEvent);
    return new Scaffold(
      key: globalKey,
      body: _splashContainer(),
    );
  }
//------------------------------------------------------------------------------
  Widget _splashContainer() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: _handleTapEvent,
              child: Container(
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.8,
                  child: Image(image: AssetImage('assets/one.png'),
                  ),
                ), 
            ),
            SizedBox(height: 0.05 * screenHeight,),
            Text(
            'Be like Joe, Stay Updated ... ',
            style: TextStyle(
                fontSize: textheadsize, color: themeColor),
          ),
        ],
      ),
    );
  }
//------------------------------------------------------------------------------
  void _handleTapEvent() async {
    if (this.mounted) {
      setState(() {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new Dashboard()),
          );
//        }
      });
    }
  }
//------------------------------------------------------------------------------
}
