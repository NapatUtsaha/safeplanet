// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class local4 extends StatefulWidget {
 final String? location;
  final String? email;
  final int? id_u;

  const local4({Key? key, this.location, this.email, this.id_u})
  : super(key: key);

  @override
  State<local4> createState() => _loginState();
}

class _loginState extends State<local4> {
  Map<String, dynamic>? resultData;
  String? errorMessage;
  int? id_u;

  @override
  final formkey = GlobalKey<FormState>();

  TextEditingController rice = TextEditingController();
  TextEditingController rice_h = TextEditingController();
  TextEditingController rice_m = TextEditingController();

  TextEditingController mic = TextEditingController();
  TextEditingController mic_h = TextEditingController();
  TextEditingController mic_m = TextEditingController();

  TextEditingController iron = TextEditingController();
  TextEditingController iron_h = TextEditingController();
  TextEditingController iron_m = TextEditingController();

  TextEditingController waterh = TextEditingController();
  TextEditingController waterh_h = TextEditingController();
  TextEditingController waterh_m = TextEditingController();

  TextEditingController washing = TextEditingController();
  TextEditingController washing_h = TextEditingController();
  TextEditingController washing_m = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController phone_h = TextEditingController();
  TextEditingController phone_m = TextEditingController();

  TextEditingController fridge = TextEditingController();
  TextEditingController fridge_h = TextEditingController();
  TextEditingController fridge_m = TextEditingController();

  TextEditingController fridgesz = TextEditingController();
  TextEditingController fridgesz_h = TextEditingController();
  TextEditingController fridgesz_m = TextEditingController();

  int selectedBulbs1 = 0;
  int selectedBulbs2 = 0;
  int selectedBulbs3 = 0;
  int selectedBulbs4 = 0;
  int selectedBulbs5 = 0;
  int selectedBulbs6 = 0;
  int selectedBulbs7 = 0;
  int selectedBulbs8 = 0;

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
          
          rice.text = data['rice']?.toString() ?? '';
          rice_h.text = data['rice_h']?.toString() ?? '';
          rice_m.text = data['rice_m']?.toString() ?? '';

          mic.text = data['mic']?.toString() ?? '';
          mic_h.text = data['mic_h']?.toString() ?? '';
          mic_m.text = data['mic_m']?.toString() ?? '';

          iron.text = data['iron']?.toString() ?? '';
          iron_h.text = data['iron_h']?.toString() ?? '';
          iron_m.text = data['iron_m']?.toString() ?? '';

          waterh.text = data['waterh']?.toString() ?? '';
          waterh_h.text = data['waterh_h']?.toString() ?? '';
          waterh_m.text = data['waterh_m']?.toString() ?? '';

          washing.text = data['washing']?.toString() ?? '';
          washing_h.text = data['washing_h']?.toString() ?? '';
          washing_m.text = data['washing_m']?.toString() ?? '';

          phone.text = data['phone']?.toString() ?? '';
          phone_h.text = data['phone_h']?.toString() ?? '';
          phone_m.text = data['phone_m']?.toString() ?? '';

          fridge.text = data['fridge']?.toString() ?? '';
          fridge_h.text = data['fridge_h']?.toString() ?? '';
          fridge_m.text = data['fridge_m']?.toString() ?? '';

          fridgesz.text = data['fridgesz']?.toString() ?? '';
          fridgesz_h.text = data['fridgesz_h']?.toString() ?? '';
          fridgesz_m.text = data['fridgesz_m']?.toString() ?? '';

          // ตั้งค่าตัวแปร selectedBulbs ตามข้อมูลที่ดึงมา
          selectedBulbs1 = int.tryParse(data['rice'] ?? '') ?? 0;
          selectedBulbs2 = int.tryParse(data['mic'] ?? '') ?? 0;
          selectedBulbs3 = int.tryParse(data['iron'] ?? '') ?? 0;
          selectedBulbs4 = int.tryParse(data['waterh'] ?? '') ?? 0;
          selectedBulbs5 = int.tryParse(data['washing'] ?? '') ?? 0;
          selectedBulbs6 = int.tryParse(data['phone'] ?? '') ?? 0;
          selectedBulbs7 = int.tryParse(data['fridge'] ?? '') ?? 0;
          selectedBulbs8 = int.tryParse(data['fridgesz'] ?? '') ?? 0;
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
    String url = "http://172.20.10.2/flutter_login/local4up.php";
    final response = await http.post(Uri.parse(url), body: {
      'id_u': id_u.toString(),
      'rice': rice.text.isEmpty ? '0' : rice.text,
      'rice_h': rice_h.text.isEmpty ? '0' : rice_h.text,
      'rice_m': rice_m.text.isEmpty ? '0' : rice_m.text,
      'mic': mic.text.isEmpty ? '0' : mic.text,
      'mic_h': mic_h.text.isEmpty ? '0' : mic_h.text,
      'mic_m': mic_m.text.isEmpty ? '0' : mic_m.text,
      'iron': iron.text.isEmpty ? '0' : iron.text,
      'iron_h': iron_h.text.isEmpty ? '0' : iron_h.text,
      'iron_m': iron_m.text.isEmpty ? '0' : iron_m.text,
      'waterh': waterh.text.isEmpty ? '0' : waterh.text,
      'waterh_h': waterh_h.text.isEmpty ? '0' : waterh_h.text,
      'waterh_m': waterh_m.text.isEmpty ? '0' : waterh_m.text,
      'washing': washing.text.isEmpty ? '0' : washing.text,
      'washing_h': washing_h.text.isEmpty ? '0' : washing_h.text,
      'washing_m': washing_m.text.isEmpty ? '0' : washing_m.text,
      'phone': phone.text.isEmpty ? '0' : phone.text,
      'phone_h': phone_h.text.isEmpty ? '0' : phone_h.text,
      'phone_m': phone_m.text.isEmpty ? '0' : phone_m.text,
      'fridge': fridge.text.isEmpty ? '0' : fridge.text,
      'fridge_h': fridge_h.text.isEmpty ? '0' : fridge_h.text,
      'fridge_m': fridge_m.text.isEmpty ? '0' : fridge_m.text,
      'fridgesz': fridgesz.text.isEmpty ? '0' : fridgesz.text,
      'fridgesz_h': fridgesz_h.text.isEmpty ? '0' : fridgesz_h.text,
      'fridgesz_m': fridgesz_m.text.isEmpty ? '0' : fridgesz_m.text,
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
                  'พลังงานภายในบ้าน(อื่นๆ)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

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
                      'assets/images/phone.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ที่ชาตโทรศัทพ์',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(20W/H)',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        DropdownButton<int>(
                          value: selectedBulbs6,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs6 = value!;
                              phone.text = '$value';
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
                                controller: phone_h,
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
                                controller: phone_m,
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
                      'assets/images/fridgesz.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ตู้เย็นขนาดเล็ก',
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
                          value: selectedBulbs8,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs8 = value!;
                              fridgesz.text = '$value';
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
                                controller: fridgesz_h,
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
                                controller: fridgesz_m,
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
            /////////////////////////////////////////////////
            SizedBox(height: 20),
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
                      'assets/images/fridge.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ตู้เย็นขนาดใหญ่',
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
                          value: selectedBulbs7,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs7 = value!;
                              fridge.text = '$value';
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
                                controller: fridge_h,
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
                                controller: fridge_m,
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
            //////////////////////////////////
            SizedBox(height: 20),
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
                      'assets/images/rice.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'หม้อหุ้งข้าว',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(500W/H)',
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
                              rice.text = '$value';
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
                                controller: rice_h,
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
                                controller: rice_m,
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
            /////////////////////////////////////////////////
            SizedBox(height: 20),
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
                      'assets/images/washing.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เครื่องซักผ้า',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(750W/H)',
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
                              washing.text = '$value';
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
                                controller: washing_h,
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
                                controller: washing_m,
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
            /////////////////หลอดไฟที่2/////////////////////
            SizedBox(height: 20),
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
                      'assets/images/mic.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ไมโครเวฟ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '(1150W/H)',
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
                              mic.text = '$value';
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
                                controller: mic_h,
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
                                controller: mic_m,
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
            /////////////////////////////////////////////
            SizedBox(height: 20),
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
                      'assets/images/iron.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เตารีด',
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
                          value: selectedBulbs3,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs3 = value!;
                              iron.text = '$value';
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
                                controller: iron_h,
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
                                controller: iron_m,
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
            /////////////////////////////////////////////////
            SizedBox(height: 20),
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
                      'assets/images/waterh.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เครื่องทำน้ำอุ่น',
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
                          value: selectedBulbs4,
                          onChanged: (value) {
                            setState(() {
                              selectedBulbs4 = value!;
                              waterh.text = '$value';
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
                                controller: waterh_h,
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
                                controller: waterh_m,
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
            /////////////////////////////////////////////////

            /////////////////////////////////////////////////

            /////////////////////////////////////////////////
 
 Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    update();
                    Navigator.pushNamed(
                    context,
                    'loResult',
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
            ),
          ],
        ),
      ),
    );
  }
}
