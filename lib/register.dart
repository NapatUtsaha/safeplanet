// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'home.dart';
import 'register.dart';
import 'main.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  final formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  Future sign_up() async {
    String url = "http://172.20.10.2/flutter_login/register.php";
    final response = await http.post(Uri.parse(url), body: {
      'name': name.text,
      'password': pass.text,
      'email': email.text,
    });
    var data = json.decode(response.body);
    if (data == "connection error") {
      print('Connection error');
    } else if (data == "EEEEE") {
      print('User already exists');
    } else if (data == "Succeed") {
      print('Registration succeeded');
    } else if (data == "Failed to insert data") {
      print('Failed to insert data');
    } else if (data == "Incomplete form data") {
      print('Incomplete form data');
    } else {
      print('Unexpected response: $data');
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
                  Image.asset(
                    'assets/images/logo.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(
                    height: 30,
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
                        labelText: 'ระบุชื่อ',
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
                          return 'โปรดระบุชื่อ';
                        }
                        return null;
                      },
                      controller: name,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                        labelText: 'ระบุอีเมล',
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
                  const SizedBox(
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
                        labelText: 'ระบุรหัสผ่าน',
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
                        } else if (val.length < 8) {
                          return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร';
                        }
                        return null;
                      },
                      controller: pass,
                    ),
                  ),
                  const SizedBox(
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
                        labelText: 'ยืนยันรหัสผ่าน',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                        ),
                        fillColor:
                            Colors.white, // กำหนด background color เป็นสีขาว
                        filled: true,
                      ),
                      validator: (val) {
                        if (val == null) {
                          return 'Empty';
                        } else if (val != pass.text) {
                          return 'รหัสผ่านไม่ตรงกัน';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 111, 141, 72),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        bool pass = formkey.currentState!.validate();
                        if (pass) {
                          sign_up();
                          Navigator.pushNamed(context, 'login');
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
