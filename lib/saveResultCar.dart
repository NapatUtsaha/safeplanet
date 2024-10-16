import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class saveResultCar extends StatefulWidget {
  final int id_c;

  const saveResultCar({Key? key, required this.id_c}) : super(key: key);

  @override
  State<saveResultCar> createState() => _carResultState();
}

class _carResultState extends State<saveResultCar> {
  final formkey = GlobalKey<FormState>();
  Map<String, dynamic>? resultData;
  final TextEditingController countValueController = TextEditingController();
  final TextEditingController distanceValueController = TextEditingController();
  double totalCO2 = 0;
  String? typeCar = '';
  String? userEmail = '';

  String? errorMessage;

  void initState() {
    super.initState();
    fetchResultData();
  }

  Future<void> fetchResultData() async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2/flutter_login/saveResultCar.php'),
      body: {'id_c': widget.id_c.toString()},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      if (responseBody is Map<String, dynamic>) {
        final data = responseBody['data']; // ดึงข้อมูลจาก 'data'

        setState(() {
          // อัพเดทตัวแปร TextEditingController ด้วยค่าที่ดึงมา
          countValueController.text =
              data['huCount'].toString(); // ค่าของ huCount
          distanceValueController.text =
              data['disCount'].toString(); // ค่าของ disCount

          // อัพเดทตัวแปรที่เหลือ
          totalCO2 = double.parse(data['totalCO2'].toString()); // ค่า totalCO2
          typeCar = data['typeCar']; // ค่า typeCar
          userEmail = data['userEmail']; // ค่า userEmail

          print("Data fetched and assigned to variables.");
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
    String url = "http://172.20.10.2/flutter_login/deleteCar.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id_c': widget.id_c.toString(), // ส่งค่า id_t ไปยัง PHP
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
                    'คำนวนการเดินทาง',
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
                      'assets/images/$typeCar.png',
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Center(child: Text('ไม่พบรูปภาพที่เกี่ยวข้อง'));
                      },
                    ),
                  ),
                  SizedBox(height: 30), // เพิ่มช่องว่างระหว่างรูปภาพกับข้อความ
                  if (typeCar == 'car1500')
                    Text(
                      'รถยนต์ส่วนตัวขนาดเล็ก 1,500 CC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'car1600')
                    Text(
                      'รถยนต์ส่วนตัวขนาดกลาง 1,600 CC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'car1800')
                    Text(
                      'รถยนต์ส่วนตัวขนาดกลาง 1,800 CC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'car2000')
                    Text(
                      'รถยนต์ส่วนตัวขนาดใหญ่ 2,000 CC',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'carEV')
                    Text(
                      'รถยนต์ส่วนตัว(ไฟฟ้า)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'carPick')
                    Text(
                      'รถกระบะ/SUV ส่วนตัว (ดีเซล)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'bicycle')
                    Text(
                      'เดิน/ปั่นจักรยาน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'motorbike')
                    Text(
                      'มอเตอร์ไซค์รับจ้าง/มอเตอร์ไซค์ส่วนตัว',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'songthaew')
                    Text(
                      'รถสองแถว',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'minibus')
                    Text(
                      'รถตู้/มินิบัส สาธารณะ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'bus')
                    Text(
                      'รถเมล์/รถบัส',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'busEV')
                    Text(
                      'รถเมล์/รถบัส ไฟฟ้า',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'train')
                    Text(
                      'รถไฟฟ้า BTS/MRT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (typeCar == 'airplane')
                    Text(
                      'เครื่องบิน',
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
                    controller: countValueController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // ขอบมน
                        borderSide: BorderSide(
                          color: Colors.black, // สีของขอบ
                          width: 2.0, // ความกว้างของขอบ
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black, // สีของขอบเมื่อใช้งาน
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
                      labelText: 'กรอกจำนวนผู้โดยสาร',
                      labelStyle: TextStyle(
                        color: Colors.black, // สีของ label
                      ),
                      hintText: 'กรอกจำนวนผู้โดยสาร',
                      hintStyle: TextStyle(
                        color: Colors.grey, // สีของ hint
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black, // ไอคอนด้านซ้าย
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                        color: Colors.black, // ไอคอนด้านขวา
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
                  SizedBox(height: 10),
                  TextField(
                    controller: distanceValueController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // ขอบมน
                        borderSide: BorderSide(
                          color: Colors.black, // สีของขอบ
                          width: 2.0, // ความกว้างของขอบ
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Colors.black, // สีของขอบเมื่อใช้งาน
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
                      labelText: 'กรอกระยะทาง(กิโลเมตร)',
                      labelStyle: TextStyle(
                        color: Colors.black, // สีของ label
                      ),
                      hintText: 'กรอกระยะทาง(กิโลเมตร)',
                      hintStyle: TextStyle(
                        color: Colors.grey, // สีของ hint
                      ),
                      prefixIcon: Icon(
                        Icons.car_crash_sharp,
                        color: Colors.black, // ไอคอนด้านซ้าย
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                        color: Colors.black, // ไอคอนด้านขวา
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

                  SizedBox(height: 50), // เพิ่มช่องว่างระหว่างปุ่มกับผลลัพธ์

                  Container(
                    width: MediaQuery.of(context).size.width -
                        32, // ความกว้างเต็มหน้าจอลบระยะห่าง
                    padding: EdgeInsets.all(16.0), // เพิ่มระยะห่างภายในกล่อง
                    margin: EdgeInsets.symmetric(
                        horizontal: 16.0), // เพิ่มระยะห่างภายนอกกล่อง
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 245, 232, 232), // สีพื้นหลังของกล่องที่อ่อนกว่า
                      borderRadius:
                          BorderRadius.circular(15.0), // ขอบมนที่ใหญ่ขึ้น
                      border: Border.all(
                        color: Colors.red[300]!, // สีของขอบที่อ่อนกว่า
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
                            SizedBox(
                                width: 8.0), // ระยะห่างระหว่างไอคอนและข้อความ
                            Text(
                              'เพิ่ม CO2',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${totalCO2.toStringAsFixed(2)} kg CO2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
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