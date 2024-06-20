import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:qwerty/home.dart';
import 'package:parkirku/login.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splashscreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 4), (){
      Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 300,
            ),
            const SizedBox(
              height: 35,
            ),
            const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}