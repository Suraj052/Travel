import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osgriptask/Provider/provider.dart';
import 'package:osgriptask/View/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xFF40cde8),
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (BuildContext context) => DataProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),

  );
}
