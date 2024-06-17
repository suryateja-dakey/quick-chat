import 'package:flutter/material.dart';
import 'package:chater/screens/welcome_screen.dart';
import 'package:chater/screens/login_screen.dart';
import 'package:chater/screens/registration_screen.dart';
import 'package:chater/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Color.fromARGB(137, 146, 25, 25)),
      //   ),
      // ),
      home: WelcomeScreen(),
    );
  }
}