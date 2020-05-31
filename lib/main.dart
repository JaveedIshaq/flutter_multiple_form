import 'package:flutter/material.dart';
import 'package:multiple_form_scaffold/multiform.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multiple Sca',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Multiform(),
      ),
    );
  }
}
