// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class cal1 extends StatefulWidget {
  const cal1({Key? key}) : super(key: key);

  @override
  State<cal1> createState() => _loginState();
}

class _loginState extends State<cal1> {
  @override
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final String? userEmail =
        ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(130), // ปรับความสูงของ AppBar ตามที่คุณต้องการ
        child: AppBar(
          flexibleSpace: Image.asset(
            'assets/images/้head.png',
            width: 200,
            height: 200,
          ),
          backgroundColor: Color.fromARGB(
              255, 175, 203, 144), // ตั้งค่าสีพื้นหลังของ AppBar เป็นโปร่งใส
          elevation: 100, // เอา shadow ของ AppBar ออก
        ),
      ),
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              width: double.infinity,
              height: 55, // กำหนดความกว้างของกล่องเท่ากับความกว้างสุดของหน้าจอ
              color: Color.fromARGB(255, 179, 179, 179), // กำหนดสีเทา
              child: Align(
                alignment: Alignment.centerLeft, // จัดวางข้อความทางซ้าย
                child: Padding(
                  padding: EdgeInsets.all(16.0), // เพิ่มระยะห่างขอบของกล่อง
                  child: Text(
                    'เลือกหมวดหมู่ในการคำนวน',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/home.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 119, 91, 91),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'saveLocation',
                    arguments: userEmail,
                  );
                },
                child: const Text(
                  'พลังงานภายในที่อยู่อาศัย',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 159, 203, 103),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/car.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 119, 91, 91),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'car',
                    arguments: userEmail,
                  );
                },
                child: const Text(
                  'การเดินทาง',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 159, 203, 103),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/tree.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 119, 91, 91),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'tree',
                    arguments: userEmail,
                  );
                },
                child: const Text(
                  'การปลูกต้นไม้',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 159, 203, 103),
                  ),
                ),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
