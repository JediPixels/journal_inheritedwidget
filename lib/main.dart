import 'package:flutter/material.dart';
import 'package:journal_inheritedwidget/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InheritedWidget Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Home(),
    );
  }
}