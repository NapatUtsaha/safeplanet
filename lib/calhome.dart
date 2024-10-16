import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class calhome extends StatefulWidget {
  const calhome({Key? key}) : super(key: key);

  @override
  State<calhome> createState() => _loginState();
}

class _loginState extends State<calhome> {
  final formkey = GlobalKey<FormState>();

  TextEditingController light1 = TextEditingController();
  TextEditingController light1_h = TextEditingController();
  TextEditingController light1_m = TextEditingController();
  TextEditingController light2 = TextEditingController();
  TextEditingController light2_h = TextEditingController();
  TextEditingController light2_m = TextEditingController();
  TextEditingController light3 = TextEditingController();
  TextEditingController light3_h = TextEditingController();
  TextEditingController light3_m = TextEditingController();

  int selectedBulbs1 = 0;
  int selectedBulbs2 = 0;
  int selectedBulbs3 = 0; // จำนวนหลอดไฟที่ถูกเลือกเริ่มต้น

  Future insert() async {
    String url = "http://172.20.10.2/flutter_login/insert.php";
    final response = await http.post(Uri.parse(url), body: {
      'light1': light1.text.isEmpty ? '0' : light1.text,
      'light1_h': light1_h.text.isEmpty ? '0' : light1_h.text,
      'light1_m': light1_m.text.isEmpty ? '0' : light1_m.text,
      'light2': light2.text.isEmpty ? '0' : light2.text,
      'light2_h': light2_h.text.isEmpty ? '0' : light2_h.text,
      'light2_m': light2_m.text.isEmpty ? '0' : light2_m.text,
      'light3': light3.text.isEmpty ? '0' : light3.text,
      'light3_h': light3_h.text.isEmpty ? '0' : light3_h.text,
      'light3_m': light3_m.text.isEmpty ? '0' : light3_m.text,
      
    });
    var data = json.decode(response.body);
    print(data);
    if (data == "Succeed") {
      print("insert Succeed");
    } else {
      print("insert FF");
    }
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
          padding: EdgeInsets.all(16), // เพิ่ม padding รอบๆ ขอบทั้งหมด
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
                  'พลังงานภายในที่อยู่อาศัย (แสงสว่าง)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // หลอด LED
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
                      'assets/images/light_led.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'หลอด LED',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(10W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 1),
                        DropdownButton<int>(
                          value: selectedBulbs3,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs3 = value!;
                              light3.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index หลอด'),
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
                                controller: light3_h,
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
                                controller: light3_m,
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

            // หลอดตะเกียบ
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
                      'assets/images/light2.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'หลอดตะเกียบ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(15W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 1),
                        DropdownButton<int>(
                          value: selectedBulbs2,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs2 = value!;
                              light2.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index หลอด'),
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
                                controller: light2_h,
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
                                controller: light2_m,
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

            // หลอดไส้
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
                      'assets/images/light.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'หลอดไส้',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(60W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 1),
                        DropdownButton<int>(
                          value: selectedBulbs1,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs1 = value!;
                              light1.text = '$value';
                            });
                          },
                          items: List.generate(
                            10,
                            (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text('$index หลอด'),
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
                                controller: light1_h,
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
                                controller: light1_m,
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

            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  print('Light1: ${light1.text}');
                  print('Light1 Hour: ${light1_h.text}');
                  print('Light1 Minute: ${light1_m.text}');
                  print('Light2: ${light2.text}');
                  print('Light2 Hour: ${light2_h.text}');
                  print('Light2 Minute: ${light2_m.text}');
                  print('Light3: ${light3.text}');
                  print('Light3 Hour: ${light3_h.text}');
                  print('Light3 Minute: ${light3_m.text}');
                  insert();
                  Navigator.pushNamed(context, 'calhome2');
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
          ],
        ),
      ),
    );
  }
}
