// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class carch extends StatefulWidget {
  final String? location;
  final String? email;

  const carch({Key? key, this.location, this.email}) : super(key: key);

  @override
  State<carch> createState() => _locationchState();
}

class _locationchState extends State<carch> {
  @override
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String? typeCar = arguments?['typeCar'] as String?;
    final String? userEmail = arguments?['userEmail'] as String?;
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
              height: 200,
            ),
            Text(
              'จะให้ทางAppจับระยะทางให้',
              style: TextStyle(fontSize: 23),
            ),
            Text(
              'หรือว่าจะกรอกระยะทางเองดีครับ?',
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 159, 203, 103),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'carResult2', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                    arguments: {
                      'typeCar': typeCar,
                      'userEmail': userEmail, // ส่ง userEmail ด้วย
                    }, // ส่งค่า typeTree ไปยังหน้า treeResult
                  );
                },
                child: const Text(
                  'จับระยะทางให้',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 159, 203, 103),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'carResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                    arguments: {
                      'typeCar': typeCar,
                      'userEmail': userEmail, // ส่ง userEmail ด้วย
                    }, // ส่งค่า typeTree ไปยังหน้า treeResult
                  );
                },
                child: const Text(
                  'กรอกระยะทางเอง',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            

            ///Text(
            ////'สถานที่: ${widget.location}', // แสดงสถานที่ที่ได้รับ
            ///style: TextStyle(fontSize: 20),
            ///),
            ///
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
