import 'package:first_app/Screens/home_page.dart';
import 'package:first_app/Screens/login_page.dart';
import 'package:first_app/Screens/signup_page.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/login',
      routes: {
        '/' : (context) => MyHomePage(title: "Pets!"),
        '/login' : (context) => LoginPage(title: "Login!"),
        '/signup' : (context) => SignupPage(title: "Signup!"),
      },
    );
  }
}

