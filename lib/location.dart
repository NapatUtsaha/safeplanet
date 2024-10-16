import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:safeplanet_new/c_homeresult.dart';
import 'package:safeplanet_new/c_location.dart';
import 'package:location/location.dart'; // ใช้แพ็คเกจ location
import 'package:permission_handler/permission_handler.dart'; // ใช้แพ็คเกจ permission_handler
import 'package:google_maps_flutter/google_maps_flutter.dart'; // import ไฟล์ c_homeresult.dart

class location extends StatefulWidget {
  const location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _LocationState();
}

class _LocationState extends State<location> {
  List<LoData> locationList = [];
  TextEditingController location = TextEditingController();
  String? losave;
  double? latitude; // เก็บค่า latitude
  double? longitude; // เก็บค่า longitude
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? userEmail =
        ModalRoute.of(context)!.settings.arguments as String?;
    if (userEmail != null) {
      fetchData(
          userEmail); // เรียกใช้ fetchData ด้วย userEmail ถ้ายังไม่ได้โหลดข้อมูลมา
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation(); // เรียกใช้ฟังก์ชันเพื่อดึงตำแหน่งเมื่อเข้ามาหน้านี้
  }

  Future<void> _getUserLocation() async {
    Location location = Location();

    // ตรวจสอบสถานะสิทธิ์การเข้าถึงตำแหน่ง
    var status = await Permission.location.status;
    if (status.isDenied) {
      // ขอสิทธิ์การเข้าถึงตำแหน่งใหม่ถ้าสิทธิ์ถูกปฏิเสธ
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      print("Permission granted, getting location...");
      LocationData locationData = await location.getLocation();
      latitude = locationData.latitude; // เก็บค่า latitude
      longitude = locationData.longitude; // เก็บค่า longitude
      print("Location retrieved: $latitude, $longitude");

      // เลื่อนกล้องไปที่ตำแหน่งปัจจุบัน
      if (_controller.isCompleted) {
        GoogleMapController mapController = await _controller.future;
        mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(latitude!, longitude!), // ใช้ค่าที่เก็บไว้
          ),
        );
      }
    } else {
      print("Location permission status: $status");
      print("Location permission denied");
    }
  }

  Future<void> uplocation(String userEmail) async {
    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2/flutter_login/location.php'),
        body: {
          'userEmail': userEmail.isEmpty ? '0' : userEmail,
          'location': location.text, // ใช้ location.text ตามที่คุณกำหนด
          'latitude':
              latitude != null ? latitude.toString() : '0', // แปลงเป็น String
          'longitude':
              longitude != null ? longitude.toString() : '0', // แปลงเป็น String
        },
      );

      if (response.statusCode == 200) {
        // เช็คข้อความที่ได้รับจากเซิร์ฟเวอร์
        final result = json.decode(response.body);
        if (result == 'Succeed') {
          // ถ้าเพิ่มข้อมูลสำเร็จ ไปที่หน้า calch
          Navigator.pushNamed(context, 'calch');
        } else if (result == 'Location with this email already exists') {
          // ถ้าข้อมูลซ้ำ แสดงข้อความแจ้งเตือน
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('ข้อมูลซ้ำ'),
                content: Text('สถานที่นี้เคยถูกบันทึกแล้วโดยอีเมลนี้'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด Dialog
                    },
                    child: Text('ตกลง'),
                  ),
                ],
              );
            },
          );
        } else {
          // ถ้าเพิ่มข้อมูลไม่สำเร็จ แสดงข้อความแจ้งเตือน
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('เกิดข้อผิดพลาด'),
                content: Text('ไม่สามารถเพิ่มข้อมูลได้ โปรดลองอีกครั้ง'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด Dialog
                    },
                    child: Text('ตกลง'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during data loading: $e');
      // แสดงข้อความแจ้งเตือนเมื่อเกิดข้อผิดพลาด
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('เกิดข้อผิดพลาด'),
            content:
                Text('ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้ โปรดลองอีกครั้ง'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ปิด Dialog
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> delete(String userEmail, String losave) async {
    // แสดงค่าที่ได้รับ
    print("User Email: $userEmail");
    print("location: ${losave}"); // ตรวจสอบ location

    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2/flutter_login/deleteLocation.php'),
        body: {
          'userEmail': userEmail.isEmpty ? '0' : userEmail,
          'location': losave,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        if (responseBody == 'Succeed') {
          print("Delete success");
        } else {
          print("Delete failed: $responseBody");
        }
      } else {
        print("Server error with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchData(String userEmail) async {
    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2/flutter_login/locationResult.php'),
        body: {'email': userEmail},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data); // เพิ่มการพิมพ์ข้อมูล JSON

        if (data == "No records found") {
          print('No records found');
          setState(() {
            locationList = []; // กำหนดให้เป็น list เปล่าเมื่อไม่พบข้อมูล
          });
        } else {
          List<LoData> tempList = [];
          for (var item in data) {
            tempList.add(LoData.fromJson(item));
          }
          setState(() {
            locationList =
                tempList; // กำหนดค่า carbonDataList จากข้อมูลที่โหลดมา
          });
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during data loading: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? userEmail =
        ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0), // เพิ่ม padding ถ้าต้องการ
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center, // จัดตำแหน่งกล่องให้อยู่กลางหน้าจอ
              child: SizedBox(
                width: 250, // กำหนดความกว้างของกล่องตามต้องการ
                child: Container(
                  padding: EdgeInsets.all(16.0), // เพิ่ม padding ข้างในกล่อง
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 176, 48, 38), // กำหนดสีพื้นหลังเป็นสีแดง
                    borderRadius:
                        BorderRadius.circular(10.0), // กำหนดความโค้งมนของมุม
                  ),
                  child: Center(
                    child: Text(
                      'สถานที่ที่เคยบันทึก',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // กำหนดสีตัวอักษรเป็นสีขาว
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Scrollbar(
                thickness: 6.0,
                radius: Radius.circular(10),
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment:
                          Alignment.topLeft, // จัดตำแหน่งให้ปุ่มอยู่ด้านบนซ้าย
                      child: Wrap(
                        spacing: 0, // ระยะห่างระหว่างปุ่มแนวนอน
                        runSpacing:
                          10, // ระยะห่างระหว่างปุ่มแนวตั้งเมื่อขึ้นบรรทัดใหม่
                        children: locationList.map((data) {
                          return Container(
                            child: ElevatedButton(
                              onPressed: () {
                                // แสดง Popup สำหรับให้ผู้ใช้เลือก
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('เลือกการกระทำ'),
                                      content: Text('คุณต้องการทำอะไร?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('คำนวณ'),
                                          onPressed: () {
                                            losave = data.location;
                                            print('Sending Location: $losave');
                                            print('Sending Email: $userEmail');

                                            Navigator.of(context).pop();

                                            Navigator.pushNamed(
                                              context,
                                              'locationch',
                                              arguments: {
                                                'location': losave,
                                                'email': userEmail,
                                              },
                                            );

                                            print(
                                                'Button for ID: ${data.id} pressed');
                                          },
                                        ),
                                        TextButton(
                                          child: Text('ลบ'),
                                          onPressed: () {
                                            losave = data.location;
                                            print(
                                                "Deleting Location: ${data.location}");
                                            print("User Email: $userEmail");

                                            delete(userEmail!, losave!);

                                            Navigator.of(context).pop();

                                            Navigator.pushNamed(
                                              context,
                                              'location',
                                              arguments: userEmail,
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(255, 119, 91, 91),
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(20),
                              ),
                              child: Container(
                                width: 70, // กำหนดความกว้างคงที่ให้ปุ่มวงกลม
                                height: 60, // กำหนดความสูงคงที่ให้ปุ่มวงกลม
                                alignment: Alignment.center,
                                child: Text(
                                  '${data.location}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),
            Container(
              width: 380,
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
                height: 20), // เพิ่มช่องว่างระหว่างเส้นสีดำและกล่องด้านล่าง
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[300], // สีพื้นหลังของกล่องเป็นสีเทา
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'กรอกชื่อสถานที่ที่คุณต้องการบันทึก',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                      height: 10), // เพิ่มช่องว่างระหว่างข้อความและช่องกรอก
                  TextField(
                    controller: location,
                    decoration: InputDecoration(
                      hintText: 'ชื่อสถานที่', // เพิ่ม hintText ในช่องกรอก
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // เพิ่มช่องว่างด้านล่างของช่องกรอก
                ],
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (location.text.isEmpty) {
                    // ถ้าช่องกรอกว่างเปล่า ให้แสดง Dialog แจ้งเตือน
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('กรุณากรอกชื่อสถานที่'),
                          content: Text('โปรดกรอกชื่อสถานที่ก่อนดำเนินการต่อ'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // ปิด Dialog
                              },
                              child: Text('ตกลง'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // ถ้ามีการกรอกข้อมูลแล้ว ให้ดำเนินการต่อ
                    uplocation(userEmail!);
                  }
                },
                child: Text('ถัดไป'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF4CAF50),
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
