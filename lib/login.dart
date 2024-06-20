import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parkirku/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State <LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  Future<String> getuser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("user") ?? "";
  }
  void saveData(user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("user", user);
  }
  void navHomePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Home();
    }));
  }
  // starttime() {
  //   var duration = const Duration(seconds: 2);
  //   return Timer(duration,() {
  //     getuser().then((value) {
  //       if (value != "") {
  //         navHomePage();
  //       }
  //     });
  //   });
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   starttime();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/login.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 350),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: const Color.fromARGB(255, 120, 4, 4),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 120, 4, 4)))),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email or Phone number",
                                  hintStyle: TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        print('login');
                        saveData('pokoke login');
                        navHomePage();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              const Color.fromARGB(255, 120, 4, 4),
                              const Color.fromARGB(255, 120, 4, 4),
                            ])),
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      "Forgot Password?",
                      style:
                          TextStyle(color: const Color.fromARGB(255, 120, 4, 4)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
