// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class car extends StatefulWidget {
  const car({Key? key}) : super(key: key);

  @override
  State<car> createState() => _loginState();
}

class _loginState extends State<car> {
  @override
  final formkey = GlobalKey<FormState>();
  String typeCar = '';

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
                    'เลือกการเดินทาง(การปล่อยคาร์บอนน้อยไปมากที่สุด)',
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
                            typeCar = 'bicycle'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/bicycle.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 8), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'เดิน/ปั่นจักรยาน',
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
                            typeCar = 'motorbike'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/motorbike.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'มอเตอร์ไซค์รับจ้าง/มอเตอร์ไซค์ส่วนตัว',
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
                            typeCar = 'train'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/train.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถไฟฟ้า BTS/MRT',
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
                            typeCar = 'carEV'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/carEV.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถยนต์ส่วนตัว(ไฟฟ้า)',
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
                            typeCar = 'busEV'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/busEV.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถเมล์/รถบัส ไฟฟ้า',
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
                            typeCar = 'songthaew'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/songthaew.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถสองแถว',
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
                            typeCar = 'car1500'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/car1500.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถยนต์ส่วนตัวขนาดเล็ก (1,500 CC)',
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
                            typeCar = 'car1600'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/car1600.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถยนต์ส่วนตัวขนาดกลาง (1,600 CC)',
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
                            typeCar = 'minibus'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/minibus.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถตู้/มินิบัส สาธารณะ',
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
                            typeCar = 'car1800'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/car1800.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถยนต์ส่วนตัวขนาดกลาง (1,800 CC)',
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
            SizedBox(height: 20),
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
                            typeCar = 'car2000'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/car2000.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถยนต์ส่วนตัวขนาดใหญ่ (2,000 CC)',
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
                            typeCar = 'carPick'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/carPick.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถกระบะ/SUV \nส่วนตัว(ดีเซล)',
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
            SizedBox(height: 20),
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
                            typeCar = 'bus'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/bus.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'รถเมล์/รถบัส',
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
                            typeCar = 'airplane'; // เปลี่ยนค่า typeTree
                          });
                          Navigator.pushNamed(
                            context,
                            'carch', // เปลี่ยนเป็นเส้นทางที่คุณใช้สำหรับหน้า treeResult
                            arguments: {
                              'typeCar': typeCar,
                              'userEmail': userEmail, // ส่ง userEmail ด้วย
                            }, // ส่งค่า typeTree ไปยังหน้า treeResult
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // รูปภาพที่อยู่ด้านบน
                            Image.asset(
                              'assets/images/airplane.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
                              width: 90,
                              height: 90,
                            ),
                            SizedBox(
                                height: 2), // ระยะห่างระหว่างรูปภาพและข้อความ
                            // ข้อความที่อยู่ด้านล่าง
                            const Text(
                              'เครื่องบิน',
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
            SizedBox(height: 20),
           
            SizedBox(height: 20),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
