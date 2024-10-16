import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class localhTime extends StatefulWidget {
  final String? location;
  final String? email;

  const localhTime({Key? key, this.location, this.email}) : super(key: key);

  @override
  State<localhTime> createState() => _loginState();
}

class _loginState extends State<localhTime> {
  Map<String, dynamic>? resultData;
  String? errorMessage;
  int? id_u;
  final formkey = GlobalKey<FormState>();

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

  // เพิ่มตัวแปรเก็บเวลาสำหรับแต่ละอุปกรณ์
  int light1Time = 0;
  int light2Time = 0;
  int light3Time = 0;
  int airBTime = 0;
  int airSTime = 0;
  int fanBTime = 0;
  int fanSTime = 0;
  int tvTime = 0;
  int tvlcdTime = 0;
  int tvledTime = 0;
  int comTime = 0;
  int labTime = 0;
  int riceTime = 0;
  int micTime = 0;
  int ironTime = 0;
  int waterhTime = 0;
  int washingTime = 0;
  int phoneTime = 0;
  int fridgeTime = 0;
  int fridgeszTime = 0;

  // สร้างตัวแปรสำหรับตรวจสอบสถานะการทำงานของตัวจับเวลา
  bool isLight1Running = true;
  bool isLight2Running = true;
  bool isLight3Running = true;
  bool isAirBRunning = true;
  bool isAirSRunning = true;
  bool isFanBRunning = true;
  bool isFanSRunning = true;
  bool isTVRunning = true;
  bool isTVLCDRunning = true;
  bool isTVLEDRunning = true;
  bool isComRunning = true;
  bool isLabRunning = true;
  bool isRiceRunning = true;
  bool isMicRunning = true;
  bool isIronRunning = true;
  bool isWaterhRunning = true;
  bool isWashingRunning = true;
  bool isPhoneRunning = true;
  bool isFridgeRunning = true;
  bool isFridgeszRunning = true;

  Timer? timer;
  int light1_h = 0;
  int light1_m = 0;
  int light2_h = 0;
  int light2_m = 0;
  int light3_h = 0;
  int light3_m = 0;

  int air_b_h = 0;
  int air_b_m = 0;
  int air_s_h = 0;
  int air_s_m = 0;

  int fan_b_h = 0;
  int fan_b_m = 0;
  int fan_s_h = 0;
  int fan_s_m = 0;

  int tv_h = 0;
  int tv_m = 0;

  int tvlcd_h = 0;
  int tvlcd_m = 0;

  int tvled_h = 0;
  int tvled_m = 0;

  int com_h = 0;
  int com_m = 0;

  int lab_h = 0;
  int lab_m = 0;

  int rice_h = 0;
  int rice_m = 0;

  int mic_h = 0;
  int mic_m = 0;

  int iron_h = 0;
  int iron_m = 0;

  int waterh_h = 0;
  int waterh_m = 0;

  int washing_h = 0;
  int washing_m = 0;

  int phone_h = 0;
  int phone_m = 0;

  int fridge_h = 0;
  int fridge_m = 0;

  int fridgesz_h = 0;
  int fridgesz_m = 0;

  @override
  void initState() {
    super.initState();
    fetchData(); // เรียกใช้ fetchData เพื่อดึงข้อมูลจากเซิร์ฟเวอร์
    startTimer(); // เรียกใช้ startTimer เพื่อเริ่มต้นจับเวลา
  }

  @override
  void dispose() {
    timer?.cancel(); // ยกเลิกตัวจับเวลาเมื่อปิดหน้าจอ
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isLight1Running && light1Value != null && light1Value != 0) {
          light1Time++;
          // คำนวณชั่วโมงและนาที
          light1_h = light1Time ~/ 3600;
          light1_m = (light1Time % 3600) ~/ 60;
        }
        if (isLight2Running && light2Value != null && light2Value != 0) {
          light2Time++;
          light2_h = light2Time ~/ 3600;
          light2_m = (light2Time % 3600) ~/ 60;
        }
        if (isLight3Running && light3Value != null && light3Value != 0) {
          light3Time++;
          light3_h = light3Time ~/ 3600;
          light3_m = (light3Time % 3600) ~/ 60;
        }
        if (isAirBRunning && airBValue != null && airBValue != 0) {
          airBTime++;
          air_b_h = airBTime ~/ 3600;
          air_b_m = (airBTime % 3600) ~/ 60;
        }
        if (isAirSRunning && airSValue != null && airSValue != 0) {
          airSTime++;
          air_s_h = airSTime ~/ 3600;
          air_s_m = (airSTime % 3600) ~/ 60;
        }
        if (isFanBRunning && fanBValue != null && fanBValue != 0) {
          fanBTime++;
          fan_b_h = fanBTime ~/ 3600;
          fan_b_m = (fanBTime % 3600) ~/ 60;
        }
        if (isFanSRunning && fanSValue != null && fanSValue != 0) {
          fanSTime++;
          fan_s_h = fanSTime ~/ 3600;
          fan_s_m = (fanSTime % 3600) ~/ 60;
        }
        if (isTVRunning && tvValue != null && tvValue != 0) {
          tvTime++;
          tv_h = tvTime ~/ 3600;
          tv_m = (tvTime % 3600) ~/ 60;
        }
        if (isTVLCDRunning && tvlcdValue != null && tvlcdValue != 0) {
          tvlcdTime++;
          tvlcd_h = tvlcdTime ~/ 3600;
          tvlcd_m = (tvlcdTime % 3600) ~/ 60;
        }
        if (isTVLEDRunning && tvledValue != null && tvledValue != 0) {
          tvledTime++;
          tvled_h = tvledTime ~/ 3600;
          tvled_m = (tvledTime % 3600) ~/ 60;
        }
        if (isComRunning && comValue != null && comValue != 0) {
          comTime++;
          com_h = comTime ~/ 3600;
          com_m = (comTime % 3600) ~/ 60;
        }
        if (isLabRunning && labValue != null && labValue != 0) {
          labTime++;
          lab_h = labTime ~/ 3600;
          lab_m = (labTime % 3600) ~/ 60;
        }
        if (isRiceRunning && riceValue != null && riceValue != 0) {
          riceTime++;
          rice_h = riceTime ~/ 3600;
          rice_m = (riceTime % 3600) ~/ 60;
        }
        if (isMicRunning && micValue != null && micValue != 0) {
          micTime++;
          mic_h = micTime ~/ 3600;
          mic_m = (micTime % 3600) ~/ 60;
        }
        if (isIronRunning && ironValue != null && ironValue != 0) {
          ironTime++;
          iron_h = ironTime ~/ 3600;
          iron_m = (ironTime % 3600) ~/ 60;
        }
        if (isWaterhRunning && waterhValue != null && waterhValue != 0) {
          waterhTime++;
          waterh_h = waterhTime ~/ 3600;
          waterh_m = (waterhTime % 3600) ~/ 60;
        }
        if (isWashingRunning && washingValue != null && washingValue != 0) {
          washingTime++;
          washing_h = washingTime ~/ 3600;
          washing_m = (washingTime % 3600) ~/ 60;
        }
        if (isPhoneRunning && phoneValue != null && phoneValue != 0) {
          phoneTime++;
          phone_h = phoneTime ~/ 3600;
          phone_m = (phoneTime % 3600) ~/ 60;
        }
        if (isFridgeRunning && fridgeValue != null && fridgeValue != 0) {
          fridgeTime++;
          fridge_h = fridgeTime ~/ 3600;
          fridge_m = (fridgeTime % 3600) ~/ 60;
        }
        if (isFridgeszRunning && fridgeszValue != null && fridgeszValue != 0) {
          fridgeszTime++;
          fridgesz_h = fridgeszTime ~/ 3600;
          fridgesz_m = (fridgeszTime % 3600) ~/ 60;
        }
      });
    });
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2/flutter_login/local1.php'),
      body: {
        'userEmail': widget.email.toString(),
        'location': widget.location.toString(),
      },
    );

    print('HTTP Response Status Code: ${response.statusCode}');
    print('HTTP Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic>) {
        setState(() {
          resultData = data;
          id_u = int.tryParse(data['id_u']?.toString() ?? '0');
          light1Value = int.tryParse(data['light1'] ?? '');
          light2Value = int.tryParse(data['light2'] ?? '');
          light3Value = int.tryParse(data['light3'] ?? '');

          airBValue = int.tryParse(data['air_b'] ?? '');
          airSValue = int.tryParse(data['air_s'] ?? '');

          fanBValue = int.tryParse(data['fan_b'] ?? '');
          fanSValue = int.tryParse(data['fan_s'] ?? '');

          tvValue = int.tryParse(data['tv'] ?? '');
          tvlcdValue = int.tryParse(data['tvlcd'] ?? '');
          tvledValue = int.tryParse(data['tvled'] ?? '');

          comValue = int.tryParse(data['com'] ?? '');
          labValue = int.tryParse(data['lab'] ?? '');

          riceValue = int.tryParse(data['rice'] ?? '');
          micValue = int.tryParse(data['mic'] ?? '');

          ironValue = int.tryParse(data['iron'] ?? '');
          waterhValue = int.tryParse(data['waterh'] ?? '');

          washingValue = int.tryParse(data['washing'] ?? '');
          phoneValue = int.tryParse(data['phone'] ?? '');

          fridgeValue = int.tryParse(data['fridge'] ?? '');
          fridgeszValue = int.tryParse(data['fridgesz'] ?? '');

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
    String url = "http://172.20.10.2/flutter_login/updateTime.php";
    final response = await http.post(Uri.parse(url), body: {
      'id_u': id_u.toString(),
      'light1_h': light1_h.toString(),
      'light1_m': light1_m.toString(),
      'light2_h': light2_h.toString(),
      'light2_m': light2_m.toString(),
      'light3_h': light3_h.toString(),
      'light3_m': light3_m.toString(),
      'air_b_h': air_b_h.toString(),
      'air_b_m': air_b_m.toString(),
      'air_s_h': air_s_h.toString(),
      'air_s_m': air_s_m.toString(),
      'fan_b_h': fan_b_h.toString(),
      'fan_b_m': fan_b_m.toString(),
      'fan_s_h': fan_s_h.toString(),
      'fan_s_m': fan_s_m.toString(),
      'tv_h': tv_h.toString(),
      'tv_m': tv_m.toString(),
      'tvlcd_h': tvlcd_h.toString(),
      'tvlcd_m': tvlcd_m.toString(),
      'tvled_h': tvled_h.toString(),
      'tvled_m': tvled_m.toString(),
      'com_h': com_h.toString(),
      'com_m': com_m.toString(),
      'lab_h': lab_h.toString(),
      'lab_m': lab_m.toString(),
      'rice_h': rice_h.toString(),
      'rice_m': rice_m.toString(),
      'mic_h': mic_h.toString(),
      'mic_m': mic_m.toString(),
      'iron_h': iron_h.toString(),
      'iron_m': iron_m.toString(),
      'waterh_h': waterh_h.toString(),
      'waterh_m': waterh_m.toString(),
      'washing_h': washing_h.toString(),
      'washing_m': washing_m.toString(),
      'phone_h': phone_h.toString(),
      'phone_m': phone_m.toString(),
      'fridge_h': fridge_h.toString(),
      'fridge_m': fridge_m.toString(),
      'fridgesz_h': fridgesz_h.toString(),
      'fridgesz_m': fridgesz_m.toString(),
    });
  }

  String formatTime(int timeInSeconds) {
    int hours = timeInSeconds ~/ 3600;
    int minutes = (timeInSeconds % 3600) ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final String? userEmail =
        ModalRoute.of(context)!.settings.arguments as String?;
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
          children: [
            Container(
              width: double.infinity,
              height: 55,
              color: Color.fromARGB(255, 179, 179, 179),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'พลังงานภายในที่อยู่อาศัย',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 570,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 200, 200, 200),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (light1Value != null && light1Value != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/light.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'หลอดไส้ เวลาการใช้งาน: ${formatTime(light1Time)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLight1Running = !isLight1Running;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isLight1Running ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isLight1Running ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (light2Value != null && light2Value != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/light2.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'หลอดตะเกียบ เวลาการใช้งาน: ${formatTime(light2Time)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLight2Running = !isLight2Running;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isLight2Running ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isLight2Running ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      if (light3Value != null && light3Value != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/light_led.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'หลอดLED เวลาการใช้งาน: ${formatTime(light3Time)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLight3Running = !isLight3Running;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isLight3Running ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isLight3Running ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      // AirB Usage Card
                      if (airBValue != null && airBValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/airb.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'แอร์ใหญ่ เวลาการใช้งาน: ${formatTime(airBTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isAirBRunning = !isAirBRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isAirBRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isAirBRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// AirS Usage Card
                      if (airSValue != null && airSValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/airs.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'แอร์เล็ก เวลาการใช้งาน: ${formatTime(airSTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isAirSRunning = !isAirSRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isAirSRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isAirSRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// fanB Usage Card
                      if (fanBValue != null && fanBValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/fanb.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'พัดลมเล็ก เวลาการใช้งาน: ${formatTime(fanBTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isFanBRunning = !isFanBRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isFanBRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isFanBRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// fanS Usage Card
                      if (fanSValue != null && fanSValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/fans.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'พัดลมใหญ่ เวลาการใช้งาน: ${formatTime(fanSTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isFanSRunning = !isFanSRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isFanSRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isFanSRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// TV Usage Card
                      if (tvValue != null && tvValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/tv.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'TV เวลาการใช้งาน: ${formatTime(tvTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isTVRunning = !isTVRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isTVRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isTVRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// TVLCD Usage Card
                      if (tvlcdValue != null && tvlcdValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/tvlcd.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'TVLCD เวลาการใช้งาน: ${formatTime(tvlcdTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isTVLCDRunning = !isTVLCDRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isTVLCDRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isTVLCDRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// TVLED Usage Card
                      if (tvledValue != null && tvledValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/tvled.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'TVLED เวลาการใช้งาน: ${formatTime(tvledTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isTVLEDRunning = !isTVLEDRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isTVLEDRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isTVLEDRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                      ///////////////////////////////////////////
                      // Computer (Com) Usage Card
                      if (comValue != null && comValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/com.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'คอมพิวเตอร์ เวลาการใช้งาน: ${formatTime(comTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isComRunning = !isComRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isComRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isComRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Laptop Usage Card
                      if (labValue != null && labValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/laptop.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'แลบท็อป เวลาการใช้งาน: ${formatTime(labTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLabRunning = !isLabRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isLabRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isLabRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                      /////////////////////////////////////////
                      // Rice Cooker Usage Card
                      if (riceValue != null && riceValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/rice.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                            title: Text(
                              'หม้อหุ้งข้าว เวลาการใช้งาน: ${formatTime(riceTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isRiceRunning = !isRiceRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isRiceRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isRiceRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Microwave Usage Card
                      if (micValue != null && micValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/mic.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'ไมโครเวฟ เวลาการใช้งาน: ${formatTime(micTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isMicRunning = !isMicRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isMicRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isMicRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Iron Usage Card
                      if (ironValue != null && ironValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/iron.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'เตารีด เวลาการใช้งาน: ${formatTime(ironTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isIronRunning = !isIronRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isIronRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isIronRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Water Heater Usage Card
                      if (waterhValue != null && waterhValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/waterh.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'เครื่องทำน้ำอุ่น เวลาการใช้งาน: ${formatTime(waterhTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isWaterhRunning = !isWaterhRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isWaterhRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isWaterhRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Washing Machine Usage Card
                      if (washingValue != null && washingValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/washing.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'เครื่องซักผ้า เวลาการใช้งาน: ${formatTime(washingTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isWashingRunning = !isWashingRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isWashingRunning
                                    ? Colors.red
                                    : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isWashingRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                      ///////////////////////////////////////////////////
                      // Phone Charger Usage Card
                      if (phoneValue != null && phoneValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/phone.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                            title: Text(
                              'ที่ชาร์จโทรศัพท์ เวลาการใช้งาน: ${formatTime(phoneTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isPhoneRunning = !isPhoneRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isPhoneRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isPhoneRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Fridge Usage Card
                      if (fridgeValue != null && fridgeValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/fridge.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'ตู้เย็น เวลาการใช้งาน: ${formatTime(fridgeTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isFridgeRunning = !isFridgeRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isFridgeRunning ? Colors.red : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isFridgeRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

// Small Fridge Usage Card
                      if (fridgeszValue != null && fridgeszValue != 0)
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              child: Image.asset(
                                'assets/images/fridgesz.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'ตู้เย็นเล็ก เวลาการใช้งาน: ${formatTime(fridgeszTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isFridgeszRunning = !isFridgeszRunning;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isFridgeszRunning
                                    ? Colors.red
                                    : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                isFridgeszRunning ? 'หยุด' : 'เริ่ม',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 16.0), // เพิ่มระยะห่างจากขอบด้านขวา
                child: ElevatedButton(
                  onPressed: () {
                    update();
                    Navigator.pushNamed(
                      context,
                      'loResult',
                      arguments: {
                        'location': widget.location,
                        'email': widget.email,
                      },
                    );
                  },
                  child: Text('ถัดไป'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF4CAF50),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
