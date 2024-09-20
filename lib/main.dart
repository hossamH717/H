import 'package:flutter/material.dart';
import 'package:flutter_application_3/login/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product List',
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFCEDDEE)),
      home: LoginPage(),
    );
  }
}

void main() {
  runApp(MyApp());
}
