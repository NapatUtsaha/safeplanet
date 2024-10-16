// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class tree extends StatefulWidget {
  const tree({Key? key}) : super(key: key);

  @override
  State<tree> createState() => _loginState();
}

class _loginState extends State<tree> {
  @override
  final formkey = GlobalKey<FormState>();
  String typeTree = '';

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
        child: ListView(
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
                    'เลือกกิจกรรมการปลูกต้นไม้',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่ม
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1, // รักษาสัดส่วน 1:1
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Color.fromARGB(255, 111, 141, 72),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // ปรับความโค้งมนของปุ่ม
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            typeTree = 'chilipepper'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'treeResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'treetype': typeTree,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/chilipepper.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 8), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'กลุ่มพรรณไม้รอบรั่วกินได้',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1, // รักษาสัดส่วน 1:1
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Color.fromARGB(255, 111, 141, 72),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // ปรับความโค้งมนของปุ่ม
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            typeTree = 'tamarind'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'treeResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'treetype': typeTree,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/tamarind.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'กระถินยักษ์',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่ม
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1, // รักษาสัดส่วน 1:1
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Color.fromARGB(255, 111, 141, 72),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // ปรับความโค้งมนของปุ่ม
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            typeTree = 'mangrove'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'treeResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'treetype': typeTree,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/mangrove.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'กลุ่มพรรณไม้ป่าชายเลน',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1, // รักษาสัดส่วน 1:1
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Color.fromARGB(255, 111, 141, 72),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // ปรับความโค้งมนของปุ่ม
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            typeTree = 'bigtree'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'treeResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'treetype': typeTree,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/bigtree.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'กลุ่มพรรณไม้ใหญ่',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่ม
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1, // รักษาสัดส่วน 1:1
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Color.fromARGB(255, 111, 141, 72),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // ปรับความโค้งมนของปุ่ม
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            typeTree = 'maple'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'treeResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'treetype': typeTree,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/maple.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'พรรณไม้ริมถนน',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: AspectRatio(
                      aspectRatio: 1, // รักษาสัดส่วน 1:1
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Color.fromARGB(255, 111, 141, 72),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // ปรับความโค้งมนของปุ่ม
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            typeTree = 'eucalyptus'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'treeResult', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'treetype': typeTree,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/eucalyptus.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'ยูคาลิปตัส',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่ม
            
            SizedBox(height: 20), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่ม
            
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
