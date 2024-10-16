// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:safeplanet_new/calhome.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class local2 extends StatefulWidget {
  final String? location;
  final String? email;
  final int? id_u;

  const local2({Key? key, this.location, this.email, this.id_u})
      : super(key: key);

  @override
  State<local2> createState() => _loginState();
}

class _loginState extends State<local2> {
  Map<String, dynamic>? resultData;
  String? errorMessage;
  @override
  final formkey = GlobalKey<FormState>();

  TextEditingController air_b = TextEditingController();
  TextEditingController air_b_h = TextEditingController();
  TextEditingController air_b_m = TextEditingController();

  TextEditingController air_s = TextEditingController();
  TextEditingController air_s_h = TextEditingController();
  TextEditingController air_s_m = TextEditingController();

  TextEditingController fan_b = TextEditingController();
  TextEditingController fan_b_h = TextEditingController();
  TextEditingController fan_b_m = TextEditingController();

  TextEditingController fan_s = TextEditingController();
  TextEditingController fan_s_h = TextEditingController();
  TextEditingController fan_s_m = TextEditingController();

  int selectedBulbs1 = 0;
  int selectedBulbs2 = 0;
  int selectedBulbs3 = 0;
  int selectedBulbs4 = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2/flutter_login/local2.php'),
      body: {
        'id_u': widget.id_u.toString(),
        
      },
    );

    print('HTTP Response Status Code: ${response.statusCode}');
    print('HTTP Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic>) {
        setState(() {
          resultData = data;
          air_b.text = data['air_b']?.toString() ?? '';
          air_b_h.text = data['air_b_h']?.toString() ?? '';
          air_b_m.text = data['air_b_m']?.toString() ?? '';
          air_s.text = data['air_s']?.toString() ?? '';
          air_s_h.text = data['air_s_h']?.toString() ?? '';
          air_s_m.text = data['air_s_m']?.toString() ?? '';
          fan_b.text = data['fan_b']?.toString() ?? '';
          fan_b_h.text = data['fan_b_h']?.toString() ?? '';
          fan_b_m.text = data['fan_b_m']?.toString() ?? '';
          fan_s.text = data['fan_s']?.toString() ?? '';
          fan_s_h.text = data['fan_s_h']?.toString() ?? '';
          fan_s_m.text = data['fan_s_m']?.toString() ?? '';

          // ตั้งค่าตัวแปร selectedBulbs ตามข้อมูลที่ดึงมา
          selectedBulbs1 = int.tryParse(data['air_b'] ?? '') ?? 0;
          selectedBulbs2 = int.tryParse(data['air_s'] ?? '') ?? 0;
          selectedBulbs3 = int.tryParse(data['fan_b'] ?? '') ?? 0;
          selectedBulbs4 = int.tryParse(data['fan_s'] ?? '') ?? 0;
          // Populate TextEditingControllers with the retrieved data
        });
      } else if (data is String) {
        setState(() {
          errorMessage = data;
        });
      }
    } else {
      setState(() {
        errorMessage = 'Failed to load data';
      });
    }
  }

  Future update() async {
    String url = "http://172.20.10.2/flutter_login/local2up.php";
    final response = await http.post(Uri.parse(url), body: {
      'userEmail': widget.email.toString(),
      'location': widget.location.toString(),
      'air_b': air_b.text.isEmpty ? '0' : air_b.text,
      'air_b_h': air_b_h.text.isEmpty ? '0' : air_b_h.text,
      'air_b_m': air_b_m.text.isEmpty ? '0' : air_b_m.text,
      'air_s': air_s.text.isEmpty ? '0' : air_s.text,
      'air_s_h': air_s_h.text.isEmpty ? '0' : air_s_h.text,
      'air_s_m': air_s_m.text.isEmpty ? '0' : air_s_m.text,
      'fan_b': fan_b.text.isEmpty ? '0' : fan_b.text,
      'fan_b_h': fan_b_h.text.isEmpty ? '0' : fan_b_h.text,
      'fan_b_m': fan_b_m.text.isEmpty ? '0' : fan_b_m.text,
      'fan_s': fan_s.text.isEmpty ? '0' : fan_s.text,
      'fan_s_h': fan_s_h.text.isEmpty ? '0' : fan_s_h.text,
      'fan_s_m': fan_s_m.text.isEmpty ? '0' : fan_s_m.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data == "Succeed") {
      Navigator.pushNamed(context, 'Succeed');
    }
    if (data == "Failed") {
      Navigator.pushNamed(context, 'Failed');
    }
    if (data == "Incomplete Data") {
      Navigator.pushNamed(context, 'Incomplete Data');
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
                  'พลังงานภายในบ้าน (เครื่องปรับอากาศ)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // พัดลมขนาดเล็ก
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
                      'assets/images/fans.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'พัดลม (ขนาดเล็ก)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(30W/H)',
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
                              fan_s.text = '$value';
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
                                controller: fan_s_h,
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
                                controller: fan_s_m,
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

            // พัดลมขนาดใหญ่
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
                      'assets/images/fanb.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'พัดลม (ขนาดใหญ่)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(75W/H)',
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
                              fan_b.text = '$value';
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
                                controller: fan_b_h,
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
                                controller: fan_b_m,
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

            // แอร์ขนาดเล็ก
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
                      'assets/images/airs.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'แอร์ (ขนาดเล็ก)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(1500W/H)',
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
                              air_s.text = '$value';
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
                                controller: air_s_h,
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
                                controller: air_s_m,
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

            // แอร์ขนาดใหญ่
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
                      'assets/images/airb.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'แอร์ (ขนาดใหญ่)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(3000W/H)',
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
                              air_b.text = '$value';
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
                                controller: air_b_h,
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
                                controller: air_b_m,
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
                  update();
                  Navigator.pushNamed(
                    context,
                    'local3',
                     arguments: {
                      'id_u': widget.id_u,
                      'location': widget.location,
                      'email': widget.email,
                    },
                  );
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
