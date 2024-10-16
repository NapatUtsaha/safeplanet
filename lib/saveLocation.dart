// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:location/location.dart';
import 'dart:async';
import 'dart:ui';
import 'package:location/location.dart'; // ใช้แพ็คเกจ location
import 'package:permission_handler/permission_handler.dart'; // ใช้แพ็คเกจ permission_handler
import 'package:google_maps_flutter/google_maps_flutter.dart';

class saveLocation extends StatefulWidget {
  const saveLocation({Key? key}) : super(key: key);

  @override
  State<saveLocation> createState() => _loginState();
}

class _loginState extends State<saveLocation> {
  double? latitude; // เก็บค่า latitude
  double? longitude;
  late String userEmail;

  int? light1Value;
  int? light2Value;
  int? light3Value;
  int? airBValue;
  int? airSValue;
  int? fanBValue;
  int? fanSValue;
  int? tvValue;
  int? tvlcdValue;
  int? tvledValue;
  int? comValue;
  int? labValue;
  int? riceValue;
  int? micValue;
  int? ironValue;
  int? waterhValue;
  int? washingValue;
  int? phoneValue;
  int? fridgeValue;
  int? fridgeszValue;
  String? location_name;

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
      await fetchData(userEmail);
    } else {
      print("Location permission status: $status");
      print("Location permission denied");
    }
  }

 Future<void> fetchData(String userEmail) async {
  final response = await http.post(
    Uri.parse('http://172.20.10.2/flutter_login/saveLocation.php'),
    body: {
      'latitude': latitude != null ? latitude.toString() : '0',
      'longitude': longitude != null ? longitude.toString() : '0',
    },
  );

  // Print Response Body
  if (response.statusCode == 200) {
    try {
      final result = json.decode(response.body);
      if (result['status'] == 'success') {
        print('Location Name: ${result['location_name']}');

        // Check if there is data in test2_data
        if (result.containsKey('test2_data')) {
          var test2Data = result['test2_data'];
          print('Test2 Data: $test2Data'); // Show data from test2

          // Store values in designated variables
          light1Value = int.parse(test2Data['light1'].toString());
          light2Value = int.parse(test2Data['light2'].toString());
          light3Value = int.parse(test2Data['light3'].toString());
          airBValue = int.parse(test2Data['air_b'].toString());
          airSValue = int.parse(test2Data['air_s'].toString());
          fanBValue = int.parse(test2Data['fan_b'].toString());
          fanSValue = int.parse(test2Data['fan_s'].toString());
          tvValue = int.parse(test2Data['tv'].toString());
          tvlcdValue = int.parse(test2Data['tvlcd'].toString());
          tvledValue = int.parse(test2Data['tvled'].toString());
          comValue = int.parse(test2Data['com'].toString());
          labValue = int.parse(test2Data['lab'].toString());
          riceValue = int.parse(test2Data['rice'].toString());
          micValue = int.parse(test2Data['mic'].toString());
          ironValue = int.parse(test2Data['iron'].toString());
          waterhValue = int.parse(test2Data['waterh'].toString());
          washingValue = int.parse(test2Data['washing'].toString());
          phoneValue = int.parse(test2Data['phone'].toString());
          fridgeValue = int.parse(test2Data['fridge'].toString());
          fridgeszValue = int.parse(test2Data['fridgesz'].toString());
          location_name = test2Data['location'];

          // Update UI after setting location_name
          setState(() {});
          print("Location Name: $location_name");
        } else if (result.containsKey('message')) {
          print('Message: ${result['message']}');
          
          // Navigate to 'location' screen if no data found
          
        }
      } else {
        print('Error: ${result['message']}');
        print('userEmail: $userEmail');
        Navigator.pushNamed(
              context,
              'location',
              arguments: userEmail,
            );
      }
    } catch (e) {
      print('JSON parsing error: $e');
    }
  } else {
    print('HTTP Response Status Code: ${response.statusCode}');
    print('Failed to fetch data from server.');
  }
}


  Widget _buildListTile(String imagePath, String title, int value) {
    if (value != 0) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // มุมโค้งมนของ Card
        ),
        child: ListTile(
          leading:
              Image.asset(imagePath, width: 50, height: 50), // ขยายขนาดไอคอน
          title: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // จัดเรียงให้ข้อความอยู่ชิดซ้ายและค่าอยู่ชิดขวา
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black), // ขยายขนาดและสไตล์ข้อความ
              ),
              Text(
                'X $value   ',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black), // ขยายขนาดและสไตล์ข้อความ
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(12), // เพิ่ม Padding ให้ ListTile
        ),
      );
    }
    return SizedBox.shrink(); // หาก value เป็น 0 ให้ไม่แสดง
  }

  @override
  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    userEmail = (ModalRoute.of(context)!.settings.arguments as String?)!;
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
                    'พลังงานภายในที่อยู่อาศัย ',
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
              height: 35,
            ),
            Align(
              alignment: Alignment.center, // จัดตำแหน่งให้อยู่ทางด้านซ้าย
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16), // กำหนด padding เพื่อให้ขนาดกล่องพอดี
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'สถานที่: ' +
                      (location_name != null && location_name!.isNotEmpty
                          ? location_name!
                          : 'กำลังโหลดข้อมูลสถานที่'), // แสดง "สถานที่:" และค่า location_name
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 233, 233, 233), // สีพื้นหลังสีขาว
                  borderRadius: BorderRadius.circular(16), // มุมโค้งมน
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // เงาที่เด่นขึ้น
                      blurRadius: 15, // ขอบเงานุ่ม
                      offset: Offset(0, 6), // ตำแหน่งเงา
                    ),
                  ],
                ),
                height: 450, // เพิ่มความสูงของกล่อง
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        vertical: 20), // เพิ่ม Padding ให้เนื้อหาภายใน
                    children: [
                      // สร้างรายการทั้งหมดใน ListTile
                      _buildListTile('assets/images/light_led.png', 'หลอด LED',
                          light3Value ?? 0),
                      _buildListTile('assets/images/light2.png', 'หลอดตะเกียบ',
                          light2Value ?? 0),
                      _buildListTile(
                          'assets/images/light.png', 'หลอดไส้', light1Value ?? 0),
                      _buildListTile('assets/images/fans.png', 'พัดลมขนาดเล็ก',
                          fanSValue ?? 0),
                      _buildListTile('assets/images/fanb.png', 'พัดลมขนาดใหญ่',
                          fanBValue ?? 0),
                      _buildListTile(
                          'assets/images/airs.png', 'แอร์ขนาดเล็ก', airSValue ?? 0),
                      _buildListTile(
                          'assets/images/airb.png', 'แอร์ขนาดใหญ่', airBValue ?? 0),
                      _buildListTile(
                          'assets/images/laptop.png', 'Laptop', labValue ?? 0),
                      _buildListTile(
                          'assets/images/tvled.png', 'TV LED', tvledValue ?? 0),
                      _buildListTile('assets/images/tv.png', 'TV', tvValue ?? 0),
                      _buildListTile(
                          'assets/images/tvlcd.png', 'TV LCD', tvlcdValue ?? 0),
                      _buildListTile(
                          'assets/images/com.png', 'Computer', comValue ?? 0),
                      _buildListTile('assets/images/phone.png',
                          'ที่ชาร์จโทรศัพท์', phoneValue ?? 0),
                      _buildListTile('assets/images/fridgesz.png',
                          'ตู้เย็น(เล็ก)', fridgeszValue ?? 0),
                      _buildListTile('assets/images/fridge.png',
                          'ตู้เย็น(ใหญ่)', fridgeValue ?? 0),
                      _buildListTile(
                          'assets/images/rice.png', 'หม้อหุ้งข้าว', riceValue ?? 0),
                      _buildListTile('assets/images/washing.png',
                          'เครื่องซักผ้า', washingValue ?? 0),
                      _buildListTile(
                          'assets/images/mic.png', 'ไมโครเวฟ', micValue ?? 0),
                      _buildListTile(
                          'assets/images/iron.png', 'เตารีด', ironValue ?? 0),
                      _buildListTile('assets/images/waterh.png',
                          'เครื่องทำน้ำอุ่น', waterhValue ?? 0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // กระจายปุ่มให้สุดขอบทั้งสองด้าน
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        'location',
                        arguments: userEmail,
                      );
                    },
                    child: Text('แก้ไข้สถานที่'),
                    // ข้อความภายในปุ่ม
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 162, 133, 90),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16), // กำหนดขนาดของปุ่ม
                      textStyle:
                          TextStyle(fontSize: 18), // กำหนดขนาดตัวอักษรในปุ่ม
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        'locationch',
                        arguments: {
                          'location': location_name,
                          'email': userEmail,
                        },
                      );
                    },
                    child: Text('ถัดไป'), // ข้อความภายในปุ่ม
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 254, 254, 254),
                      backgroundColor: Color.fromARGB(255, 159, 203, 103),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16), // กำหนดขนาดของปุ่ม
                      textStyle:
                          TextStyle(fontSize: 18), // กำหนดขนาดตัวอักษรในปุ่ม
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
