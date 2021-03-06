import 'package:flutter/material.dart';
import 'package:myservices/services/authentication.dart';
import 'package:myservices/services/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'MyServices',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
