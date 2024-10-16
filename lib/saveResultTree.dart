import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class saveResultTree extends StatefulWidget {
  final int id_t;

  const saveResultTree({Key? key, required this.id_t}) : super(key: key);

  @override
  State<saveResultTree> createState() => _treeResultState();
}

class _treeResultState extends State<saveResultTree> {
  final formkey = GlobalKey<FormState>();
  Map<String, dynamic>? resultData;
  final TextEditingController treeValueController = TextEditingController();
  String treetype = '';
  double carbonFootprint = 0;
  String? errorMessage;
  String? userEmail;

  void initState() {
    super.initState();
    fetchResultData();
  }

  Future<void> fetchResultData() async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2/flutter_login/saveResultTree.php'),
      body: {'id_t': widget.id_t.toString()},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      if (responseBody is Map<String, dynamic>) {
        final data = responseBody['data']; // ดึงข้อมูลจาก 'data'

        setState(() {
          resultData = data;
          print("data = $data");

          carbonFootprint = double.tryParse(data['ReduceCO2'].toString()) ?? 0;

          // ตั้งค่าข้อมูล
          treeValueController.text = data['treeCount'].toString();
          treetype = data['treeType'].toString();
          userEmail = data['userEmail'].toString();
        });
      } else if (responseBody is String) {
        setState(() {
          errorMessage = responseBody;
        });
      }
    } else {
      setState(() {
        errorMessage = 'Failed to load data';
      });
    }
  }

  Future<void> update() async {
    String url = "http://172.20.10.2/flutter_login/deleteTree.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id_t': widget.id_t.toString(), // ส่งค่า id_t ไปยัง PHP
        },
      );

      // ตรวจสอบสถานะของการตอบกลับจากเซิร์ฟเวอร์
      if (response.statusCode == 200) {
        // แปลงผลลัพธ์จาก JSON เป็นข้อความ
        var responseBody = json.decode(response.body);

        if (responseBody == 'Succeed') {
          // หากลบข้อมูลสำเร็จ
          print("Delete success");
        } else {
          // หากเกิดข้อผิดพลาด เช่น id_t หายไป หรือการลบไม่สำเร็จ
          print("Delete failed: $responseBody");
        }
      } else {
        // กรณีที่เกิดข้อผิดพลาดจากการเชื่อมต่อ
        print("Server error with status code: ${response.statusCode}");
      }
    } catch (e) {
      // จัดการข้อผิดพลาดเมื่อไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'คำนวนการลดCO2จากการปลูกต้นไม้',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่ม

            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // เพิ่ม padding เพื่อให้รูปไม่ชนขอบหน้าจอ
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 2, // ใช้อัตราส่วน 1:1 สำหรับรูปภาพ
                    child: Image.asset(
                      'assets/images/$treetype.png',
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Center(child: Text('ไม่พบรูปภาพที่เกี่ยวข้อง'));
                      },
                    ),
                  ),
                  SizedBox(height: 30), // เพิ่มช่องว่างระหว่างรูปภาพกับข้อความ
                  if (treetype == 'chilipepper')
                    Text(
                      'กลุ่มพรรณไม้รอบรั่วกินได้',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (treetype == 'tamarind')
                    Text(
                      'กระถินยักษ์',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (treetype == 'mangrove')
                    Text(
                      'กลุ่มพรรณไม้ป่าชายเลน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (treetype == 'bigtree')
                    Text(
                      'กลุ่มพรรณไม้ใหญ่',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (treetype == 'maple')
                    Text(
                      'พรรณไม้ริมถนน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (treetype == 'eucalyptus')
                    Text(
                      'ยูคาลิปตัส',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(
                      height: 20), // เพิ่มช่องว่างระหว่างข้อความกับกล่องข้อความ
                  TextField(
                    controller: treeValueController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // ขอบมน
                        borderSide: BorderSide(
                          color: Colors.green, // สีของขอบ
                          width: 2.0, // ความกว้างของขอบ
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.green, // สีของขอบเมื่อใช้งาน
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.blue, // สีของขอบเมื่อโฟกัส
                          width: 2.0,
                        ),
                      ),
                      labelText: 'กรอกจำนวนต้นไม้',
                      labelStyle: TextStyle(
                        color: Colors.green, // สีของ label
                      ),
                      hintText: 'กรอกจำนวนต้นไม้ที่คุณต้องการปลูก',
                      hintStyle: TextStyle(
                        color: Colors.grey, // สีของ hint
                      ),
                      prefixIcon: Icon(
                        Icons.nature,
                        color: Colors.green, // ไอคอนด้านซ้าย
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                        color: Colors.green, // ไอคอนด้านขวา
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(
                          255, 255, 255, 255), // สีพื้นหลังของ TextField
                    ),
                    keyboardType:
                        TextInputType.number, // กำหนดให้เป็นแป้นพิมพ์ตัวเลข
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                      height:
                          10), // เพิ่มช่องว่างระหว่างกล่องข้อความกับปุ่มคำนวณ

                  SizedBox(height: 120), // เพิ่มช่องว่างระหว่างปุ่มกับผลลัพธ์

                  Container(
                    width: MediaQuery.of(context).size.width -
                        32, // ความกว้างเต็มหน้าจอลบระยะห่าง
                    padding: EdgeInsets.all(16.0), // เพิ่มระยะห่างภายในกล่อง
                    margin: EdgeInsets.symmetric(
                        horizontal: 16.0), // เพิ่มระยะห่างภายนอกกล่อง
                    decoration: BoxDecoration(
                      color: Colors.green[50], // สีพื้นหลังของกล่องที่อ่อนกว่า
                      borderRadius:
                          BorderRadius.circular(15.0), // ขอบมนที่ใหญ่ขึ้น
                      border: Border.all(
                        color: Colors.green[300]!, // สีของขอบที่อ่อนกว่า
                        width: 2.5, // ความกว้างของขอบที่ใหญ่ขึ้น
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.2), // สีของเงาที่อ่อน
                          spreadRadius: 2, // การกระจายของเงา
                          blurRadius: 5, // การเบลอของเงา
                          offset: Offset(0, 3), // ตำแหน่งของเงา
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // จัดให้ข้อความอยู่ซ้าย และค่าตัวเลขอยู่ขวา
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.eco, // ไอคอนที่สื่อถึงธรรมชาติ
                              color: Colors.green[600], // สีของไอคอน
                              size: 24.0, // ขนาดของไอคอน
                            ),
                            SizedBox(
                                width: 8.0), // ระยะห่างระหว่างไอคอนและข้อความ
                            Text(
                              'ดูดซับ CO2',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${carbonFootprint.toStringAsFixed(2)} kg CO2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // กระจายปุ่มให้สุดขอบทั้งสองด้าน
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            update();
                            Navigator.pushNamed(
                              context,
                              'home',
                              arguments: userEmail,
                            );
                          },
                          child: Text('ลบที่บันทึก'),
                          // ข้อความภายในปุ่ม
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Color(0xFFF44336),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16), // กำหนดขนาดของปุ่ม
                            textStyle: TextStyle(
                                fontSize: 18), // กำหนดขนาดตัวอักษรในปุ่ม
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            print('Tree Type: $treetype');
                            print('Tree Count: $treeValueController');
                            print(
                                'Carbon Footprint: ${carbonFootprint.toStringAsFixed(2)}');
                            print('User Email: $userEmail');
                            Navigator.pushNamed(
                              context,
                              'home',
                              arguments: userEmail,
                            );
                          },
                          child: Text('กลับหน้าแรก'), // ข้อความภายในปุ่ม
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 254, 254, 254), backgroundColor: Color.fromARGB(
                                255, 159, 203, 103),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 16), // กำหนดขนาดของปุ่ม
                            textStyle: TextStyle(
                                fontSize: 18), // กำหนดขนาดตัวอักษรในปุ่ม
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
