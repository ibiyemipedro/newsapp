import 'package:bong/views/splash.dart';
import 'package:flutter/material.dart';

import 'views/splash.dart';
import 'views/dashboard.dart';

void main() {
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    Dashboard.tag: (context) => Dashboard(),
  };

  // This widget is the root of your application. This is a test text
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bong App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Molly',
      ),
      home: SplashPage(),
      routes: routes,
    );
  }
}
