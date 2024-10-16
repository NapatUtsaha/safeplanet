import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safeplanet_new/c_car.dart';
import 'dart:convert';
import 'package:safeplanet_new/c_homeresult.dart';
import 'package:safeplanet_new/c_tree.dart'; // import ไฟล์ c_homeresult.dart

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CarbonData> carbonDataList = [];
  List<CarData> carDataList = [];
  List<TreeData> treeDataList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? userEmail =
        ModalRoute.of(context)!.settings.arguments as String?;
    if (userEmail != null && carbonDataList.isEmpty) {
      fetchData(
          userEmail); // เรียกใช้ fetchData ด้วย userEmail ถ้ายังไม่ได้โหลดข้อมูลมา
    }
  }

  Future<void> fetchData(String userEmail) async {
    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2/flutter_login/homeResult.php'),
        body: {'email': userEmail},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data); // ตรวจสอบข้อมูลที่ได้จาก PHP

        // จัดการข้อมูลจาก table test2
        if (data['result2'] == null || data['result2'].isEmpty) {
          print('No records found in result2');
        } else {
          List<CarbonData> tempListresult2 = [];
          for (var item in data['result2']) {
            tempListresult2.add(
                CarbonData.fromJson(item)); // แปลงข้อมูล JSON เป็น CarbonData
          }
          setState(() {
            carbonDataList = tempListresult2; // กำหนดข้อมูลจาก table test2
          });
        }

        // จัดการข้อมูลจาก table car
        if (data['car'] == null || data['car'].isEmpty) {
          print('No records found in car');
        } else {
          List<CarData> tempListCar = [];
          for (var item in data['car']) {
            tempListCar
                .add(CarData.fromJson(item)); // แปลงข้อมูล JSON เป็น CarData
          }
          setState(() {
            carDataList = tempListCar; // กำหนดข้อมูลจาก table car
          });
        }

        if (data['tree'] == null || data['tree'].isEmpty) {
          print('No records found in tree');
        } else {
          List<TreeData> tempListTree = [];
          for (var item in data['tree']) {
            tempListTree
                .add(TreeData.fromJson(item)); // แปลงข้อมูล JSON เป็น TreeData
          }
          setState(() {
            treeDataList = tempListTree; // กำหนดข้อมูลจาก table tree
          });
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during data loading: $e');
    }
  }

  Widget buildResultCard(CarbonData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft, // จัดตำแหน่งให้ชิดซ้าย
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                'saveResult',
                arguments: data.id, // ตรวจสอบว่า data.id มีค่าที่ถูกต้อง
              );
              print('Button for ID: ${data.id} pressed');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 119, 91, 91), // กำหนดสีของตัวอักษรในปุ่มเมื่อถูกกด
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // กำหนดความโค้งมนของขอบปุ่ม
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Container(
                      width: 73, // กำหนดความกว้างให้เท่ากันทุกบรรทัด
                      child: Text(
                        '${data.sumCarbon.toStringAsFixed(3)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 159, 203, 103),
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Text(
                      '           kCO2e',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white, // กำหนดสีของตัวอักษร
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  width: 1, // กำหนดความกว้างของเส้นแบ่ง
                  height: 50, // กำหนดความสูงของเส้นแบ่ง
                  color: Colors.white, // กำหนดสีของเส้นแบ่ง
                ),
                SizedBox(
                    width: 20), // เพิ่มช่องว่างระหว่างเส้นแบ่งและข้อความด้านขวา
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      data.type == 'home'
                          ? 'การใช้พลังงานภายในบ้าน'
                          : 'การใช้พลังงานภายในบ้าน',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white, // กำหนดสีของตัวอักษร
                      ),
                    ),
                    SizedBox(
                        height:
                            5), // เพิ่มช่องว่างระหว่างข้อความด้านขวาและวันที่
                    Row(
                      children: [
                        Text(
                          'Date: ${data.date}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white, // กำหนดสีของตัวอักษร
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Time: ${data.time}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white, // กำหนดสีของตัวอักษร
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildCarCard(CarData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                'saveResultCar',
                arguments: data.id_c,
              );
              print('Button for Car ID: ${data.id_c} pressed');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 215, 81, 81), // สีตัวอักษรในปุ่มเป็นสีขาว
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Container(
                      width: 73,
                      child: Text(
                        '${data.totalCO2.toStringAsFixed(3)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0), // สีฟ้าพาสเทล
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Text(
                      '           kCO2e',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'พลังงานจากการเดินทาง',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Date: ${data.date}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Time: ${data.time}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

Widget buildTreeCard(TreeData data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [
        Align(
          alignment: Alignment.centerLeft, // จัดตำแหน่งให้ชิดซ้าย
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                'saveResultTree',
                arguments: data.id_t, // ตรวจสอบว่า data.id มีค่าที่ถูกต้อง
              );
              print('Button for ID: ${data.id_t} pressed');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 159, 203, 103), // กำหนดสีของตัวอักษรในปุ่มเมื่อถูกกด
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // กำหนดความโค้งมนของขอบปุ่ม
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Container(
                      width: 73, // กำหนดความกว้างให้เท่ากันทุกบรรทัด
                      child: Text(
                        '${data.ReduceCO2.toStringAsFixed(3)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 119, 91, 91),
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Text(
                      '           kCO2e',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white, // กำหนดสีของตัวอักษร
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 10),
                Container(
                  width: 1, // กำหนดความกว้างของเส้นแบ่ง
                  height: 50, // กำหนดความสูงของเส้นแบ่ง
                  color: Colors.white, // กำหนดสีของเส้นแบ่ง
                ),
                SizedBox(
                    width: 20), // เพิ่มช่องว่างระหว่างเส้นแบ่งและข้อความด้านขวา
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                     'ลดCO2จากการปลูกต้นไม้',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // กำหนดสีของตัวอักษร
                      ),
                    ),
                    SizedBox(
                        height:
                            5), // เพิ่มช่องว่างระหว่างข้อความด้านขวาและวันที่
                    Row(
                      children: [
                        Text(
                          'Date: ${data.date}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white, // กำหนดสีของตัวอักษร
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Time: ${data.time}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white, // กำหนดสีของตัวอักษร
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
  );
}

  

  @override
Widget build(BuildContext context) {
  final String? userEmail =
      ModalRoute.of(context)!.settings.arguments as String?;

  // รวมข้อมูลจาก carDataList, treeDataList, carbonDataList
  List<dynamic> combinedList = [];
  combinedList.addAll(carDataList.map((data) => {'type': 'car', 'data': data}));
  combinedList.addAll(treeDataList.map((data) => {'type': 'tree', 'data': data}));
  combinedList.addAll(carbonDataList.map((data) => {'type': 'result2', 'data': data}));

  // จัดเรียงตามวันที่และเวลา
  combinedList.sort((a, b) {
    DateTime dateTimeA = DateTime.parse('${a['data'].date} ${a['data'].time}');
    DateTime dateTimeB = DateTime.parse('${b['data'].date} ${b['data'].time}');

    // เปรียบเทียบวันที่ก่อน
    int dateCompare = dateTimeA.compareTo(dateTimeB);
    if (dateCompare != 0) return dateCompare;

    // ถ้าวันที่เดียวกัน เปรียบเทียบเวลา
    return dateTimeA.compareTo(dateTimeB);
  });

 return Scaffold(
  backgroundColor: Colors.white,
  
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 159, 203, 103),
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            // ฟังก์ชันการทำงานของปุ่ม Logout
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ],
    ),
  ),
  body: Stack(
    children: [
      Center(
        child: ListView(
          padding: EdgeInsets.all(16.0), // เพิ่ม padding ถ้าต้องการ
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/pic_1.png', // เปลี่ยนเป็น path ของรูปภาพที่คุณต้องการใช้
              width: 400,
              height: 300,
            ),
            Container(
              width: 380,
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 215, 81, 81),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'cal1',
                    arguments: userEmail,
                  );
                },
                child: const Text(
                  'เริ่มต้นการคำนวน',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 380,
              height: 2,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'ผลการคำนวณที่บันทึก',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 300, // ปรับขนาดความสูงของกล่องตามต้องการ
              decoration: BoxDecoration(
                color: Color.fromARGB(
                    255, 242, 242, 242), // กำหนดสีพื้นหลังของกล่อง
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Scrollbar(
                thickness: 6.0, // ความหนาของแถบเลื่อน
                radius: Radius.circular(10),
                thumbVisibility: true, // ทำให้แถบเลื่อนแสดงอยู่เสมอ
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: combinedList.map((entry) {
                        var data = entry['data'];
                        switch (entry['type']) {
                          case 'car':
                            return buildCarCard(data);
                          case 'tree':
                            return buildTreeCard(data);
                          case 'result2':
                            return buildResultCard(data);
                          default:
                            return SizedBox.shrink(); // ถ้าไม่ตรงกับประเภทใดให้แสดงเป็นกล่องว่าง
                        }
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'User : $userEmail',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 40,
        left: 16,
        child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // ไอคอนจุดสามจุด
              onPressed: () {
                Scaffold.of(context).openDrawer(); // เปิด Drawer เมื่อกดปุ่ม
              },
            );
          },
        ),
      ),
    ],
  ),
);

  }
}



