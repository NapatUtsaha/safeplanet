// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  final formkey = GlobalKey<FormState>();

  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

Future sign_in() async {
  String url = "http://172.20.10.2/flutter_login/login.php";

  final response = await http.post(Uri.parse(url), body: {
    'password': pass.text,
    'email': email.text,
  });

  // Print the raw response body for debugging
  print('Raw response: ${response.body}');

    var data = json.decode(response.body);
    print(data);

    if (data == "Fail to login") {
      Navigator.pushNamed(context, 'login');
    } else if (data == "Succeed to login") {

      String userEmail = email.text;
      print('Login successful: $userEmail');
      Navigator.pushNamed(
        context,
        'home',
        arguments: userEmail,
      );
    } 
  } 



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9FCB67),
      body: Center(
        child: Form(
          key: formkey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/images/logo.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                    width: 250,
                    height: 250,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // กำหนดสีของเส้นขอบเริ่มต้น
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .white), // กำหนดสีของเส้นขอบเมื่อได้รับการโฟกัส
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'อีเมล',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                        ),
                        fillColor:
                            Colors.white, // กำหนด background color เป็นสีขาว
                        filled: true,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'โปรดระบุอีเมล';
                        }
                        return null;
                      },
                      controller: email,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // กำหนดสีของเส้นขอบเริ่มต้น
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .white), // กำหนดสีของเส้นขอบเมื่อได้รับการโฟกัส
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'รหัสผ่าน',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                        ),
                        fillColor:
                            Colors.white, // กำหนด background color เป็นสีขาว
                        filled: true,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'โปรดระบุรหัสผ่าน';
                        }
                        return null;
                      },
                      controller: pass,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 111, 141, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        bool pass = formkey.currentState!.validate();
                        if (pass) {
                          sign_in();
                        }
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 111, 141, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
