// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class calhome3 extends StatefulWidget {
  const calhome3({Key? key}) : super(key: key);

  @override
  State<calhome3> createState() => _loginState();
}

class _loginState extends State<calhome3> {
  @override
  final formkey = GlobalKey<FormState>();

  TextEditingController tv = TextEditingController();
  TextEditingController tv_h = TextEditingController();
  TextEditingController tv_m = TextEditingController();

  TextEditingController tvlcd = TextEditingController();
  TextEditingController tvlcd_h = TextEditingController();
  TextEditingController tvlcd_m = TextEditingController();

  TextEditingController tvled = TextEditingController();
  TextEditingController tvled_h = TextEditingController();
  TextEditingController tvled_m = TextEditingController();

  TextEditingController com = TextEditingController();
  TextEditingController com_h = TextEditingController();
  TextEditingController com_m = TextEditingController();

  TextEditingController lab = TextEditingController();
  TextEditingController lab_h = TextEditingController();
  TextEditingController lab_m = TextEditingController();

  int selectedBulbs1 = 0;
  int selectedBulbs2 = 0;
  int selectedBulbs3 = 0;
  int selectedBulbs4 = 0;
  int selectedBulbs5 = 0;

  Future update() async {
    String url = "http://172.20.10.2/flutter_login/update2.php";
    final response = await http.post(Uri.parse(url), body: {
      'tv': tv.text.isEmpty ? '0' : tv.text,
      'tv_h': tv_h.text.isEmpty ? '0' : tv_h.text,
      'tv_m': tv_m.text.isEmpty ? '0' : tv_m.text,
      'tvlcd': tvlcd.text.isEmpty ? '0' : tvlcd.text,
      'tvlcd_h': tvlcd_h.text.isEmpty ? '0' : tvlcd_h.text,
      'tvlcd_m': tvlcd_m.text.isEmpty ? '0' : tvlcd_m.text,
      'tvled': tvled.text.isEmpty ? '0' : tvled.text,
      'tvled_h': tvled_h.text.isEmpty ? '0' : tvled_h.text,
      'tvled_m': tvled_m.text.isEmpty ? '0' : tvled_m.text,
      'com': com.text.isEmpty ? '0' : com.text,
      'com_h': com_h.text.isEmpty ? '0' : com_h.text,
      'com_m': com_m.text.isEmpty ? '0' : com_m.text,
      'lab': lab.text.isEmpty ? '0' : lab.text,
      'lab_h': lab_h.text.isEmpty ? '0' : lab_h.text,
      'lab_m': lab_m.text.isEmpty ? '0' : lab_m.text,
    });
    var data = json.decode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: AppBar(
          flexibleSpace: Image.asset(
            'assets/images/้head.png',
            width: 200,
            height: 200,
          ),
          backgroundColor: Color.fromARGB(255, 175, 203, 144),
          elevation: 100,
        ),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'พลังงานภายในบ้าน (ทีวีและคอม)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // แลปท็อป
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/laptop.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'แลปท็อป',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(100W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<int>(
                          value: selectedBulbs5,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs5 = value!;
                              lab.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index เครื่อง'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาการใช้งาน',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ชั่วโมง',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: lab_h,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'นาที',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: lab_m,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // ทีวี LED
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/tvled.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ทีวี LED',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(150W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<int>(
                          value: selectedBulbs3,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs3 = value!;
                              tvled.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index เครื่อง'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาการใช้งาน',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ชั่วโมง',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: tvled_h,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'นาที',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: tvled_m,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // ทีวีจอแก้ว
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/tv.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ทีวีจอแก้ว',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(200W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<int>(
                          value: selectedBulbs1,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs1 = value!;
                              tv.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index เครื่อง'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาการใช้งาน',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ชั่วโมง',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: tv_h,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'นาที',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: tv_m,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // ทีวี LCD
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/tvlcd.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ทีวี LCD',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(250W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<int>(
                          value: selectedBulbs2,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs2 = value!;
                              tvlcd.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index เครื่อง'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาการใช้งาน',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ชั่วโมง',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: tvlcd_h,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'นาที',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: tvlcd_m,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // คอมพิวเตอร์
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/com.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'คอมพิวเตอร์',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(300W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<int>(
                          value: selectedBulbs4,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs4 = value!;
                              com.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index เครื่อง'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เวลาการใช้งาน',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'ชั่วโมง',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: com_h,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'นาที',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                controller: com_m,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    update();
                    Navigator.pushNamed(context, 'calhome4');
                  },
                  child: Text('ถัดไป'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
