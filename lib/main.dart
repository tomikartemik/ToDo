import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/main_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.deepPurple
  ),
    initialRoute: '/',
    routes: {
    '/': (context) => MainScreen(),
    '/todo_list': (context) => Home()
  },
));