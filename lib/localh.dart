import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class localh extends StatefulWidget {
  final String? location;
  final String? email;

  const localh({Key? key, this.location, this.email}) : super(key: key);

  @override
  State<localh> createState() => _loginState();
}

class _loginState extends State<localh> {
  Map<String, dynamic>? resultData;
  String? errorMessage;
  int? id_u;

  final formkey = GlobalKey<FormState>();

  TextEditingController light1 = TextEditingController();

  TextEditingController light2 = TextEditingController();

  TextEditingController light3 = TextEditingController();

  TextEditingController air_b = TextEditingController();

  TextEditingController air_s = TextEditingController();

  TextEditingController fan_b = TextEditingController();

  TextEditingController fan_s = TextEditingController();

  TextEditingController tv = TextEditingController();

  TextEditingController tvlcd = TextEditingController();

  TextEditingController tvled = TextEditingController();

  TextEditingController com = TextEditingController();

  TextEditingController lab = TextEditingController();

  TextEditingController rice = TextEditingController();

  TextEditingController mic = TextEditingController();

  TextEditingController iron = TextEditingController();

  TextEditingController waterh = TextEditingController();

  TextEditingController washing = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController fridge = TextEditingController();

  TextEditingController fridgesz = TextEditingController();

  static const int light1Wattage = 60;
  static const int light2Wattage = 15;
  static const int light3Wattage = 10;

  static const int airbWattage = 3000; // 3 kW
  static const int airsWattage = 1500; // 1.5 kW

  static const int fanbWattage = 75; // วัตต์
  static const int fansWattage = 30; // วัตต์

  static const int tvWattage = 200; // วัตต์
  static const int tvlcdWattage = 250; // วัตต์
  static const int tvledWattage = 150; // วัตต์

  static const int comWattage = 300;
  static const int labtopWattage = 100;

  static const int riceWattage = 500;
  static const int micWattage = 1150;
  static const int ironWattage = 1500;
  static const int waterhWattage = 3000;
  static const int washingWattage = 750;
  static const int phoneWattage = 20;
  static const int fridgeWattage = 200;
  static const int fridgeszWattage = 100;

  int selectedBulbs1 = 0;
  int selectedBulbs2 = 0;
  int selectedBulbs3 = 0;
  int selectedBulbs4 = 0;
  int selectedBulbs5 = 0;
  int selectedBulbs6 = 0;
  int selectedBulbs7 = 0;
  int selectedBulbs8 = 0;
  int selectedBulbs9 = 0;
  int selectedBulbs10 = 0;
  int selectedBulbs11 = 0;
  int selectedBulbs12 = 0;
  int selectedBulbs13 = 0;
  int selectedBulbs14 = 0;
  int selectedBulbs15 = 0;
  int selectedBulbs16 = 0;
  int selectedBulbs17 = 0;
  int selectedBulbs18 = 0;
  int selectedBulbs19 = 0;
  int selectedBulbs20 = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
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
          light1.text = data['light1']?.toString() ?? '';
          light2.text = data['light2']?.toString() ?? '';
          light3.text = data['light3']?.toString() ?? '';

          air_b.text = data['air_b']?.toString() ?? '';
          air_s.text = data['air_s']?.toString() ?? '';

          fan_b.text = data['fan_b']?.toString() ?? '';
          fan_s.text = data['fan_s']?.toString() ?? '';

          tv.text = data['tv']?.toString() ?? '';
          tvlcd.text = data['tvlcd']?.toString() ?? '';
          tvled.text = data['tvled']?.toString() ?? '';

          com.text = data['com']?.toString() ?? '';
          lab.text = data['lab']?.toString() ?? '';

          rice.text = data['rice']?.toString() ?? '';
          mic.text = data['mic']?.toString() ?? '';

          iron.text = data['iron']?.toString() ?? '';
          waterh.text = data['waterh']?.toString() ?? '';

          washing.text = data['washing']?.toString() ?? '';
          phone.text = data['phone']?.toString() ?? '';

          fridge.text = data['fridge']?.toString() ?? '';
          fridgesz.text = data['fridgesz']?.toString() ?? '';

// ตั้งค่า selectedBulbs ตามข้อมูลที่ดึงมา
          selectedBulbs1 = int.tryParse(data['light1'] ?? '') ?? 0;
          selectedBulbs2 = int.tryParse(data['light2'] ?? '') ?? 0;
          selectedBulbs3 = int.tryParse(data['light3'] ?? '') ?? 0;

          selectedBulbs4 = int.tryParse(data['air_b'] ?? '') ?? 0;
          selectedBulbs5 = int.tryParse(data['air_s'] ?? '') ?? 0;

          selectedBulbs6 = int.tryParse(data['fan_b'] ?? '') ?? 0;
          selectedBulbs7 = int.tryParse(data['fan_s'] ?? '') ?? 0;

          selectedBulbs8 = int.tryParse(data['tv'] ?? '') ?? 0;
          selectedBulbs9 = int.tryParse(data['tvlcd'] ?? '') ?? 0;
          selectedBulbs10 = int.tryParse(data['tvled'] ?? '') ?? 0;

          selectedBulbs11 = int.tryParse(data['com'] ?? '') ?? 0;
          selectedBulbs12 = int.tryParse(data['lab'] ?? '') ?? 0;

          selectedBulbs13 = int.tryParse(data['rice'] ?? '') ?? 0;
          selectedBulbs14 = int.tryParse(data['mic'] ?? '') ?? 0;

          selectedBulbs15 = int.tryParse(data['iron'] ?? '') ?? 0;
          selectedBulbs16 = int.tryParse(data['waterh'] ?? '') ?? 0;

          selectedBulbs17 = int.tryParse(data['washing'] ?? '') ?? 0;
          selectedBulbs18 = int.tryParse(data['phone'] ?? '') ?? 0;

          selectedBulbs19 = int.tryParse(data['fridge'] ?? '') ?? 0;
          selectedBulbs20 = int.tryParse(data['fridgesz'] ?? '') ?? 0;

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
  } // จำนวนหลอดไฟที่ถูกเลือกเริ่มต้น

  Future update() async {
    String url = "http://172.20.10.2/flutter_login/localh.php";
    final response = await http.post(Uri.parse(url), body: {
      'id_u': id_u.toString(),
      'light1': light1.text,
      'light2': light2.text,
      'light3': light3.text,
      'air_b': air_b.text,
      'air_s': air_s.text,
      'fan_b': fan_b.text,
      'fan_s': fan_s.text,
      'tv': tv.text,
      'tvlcd': tvlcd.text,
      'tvled': tvled.text,
      'com': com.text,
      'lab': lab.text,
      'rice': rice.text,
      'mic': mic.text,
      'iron': iron.text,
      'waterh': waterh.text,
      'washing': washing.text,
      'phone': phone.text,
      'fridge': fridge.text,
      'fridgesz': fridgesz.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data == "Succeed") {
      print("insert Succeed");
    } else {
      print("insert FF");
    }
  }

  Widget _buildItemCard(String imagePath, String title, int selectedValue,
      ValueChanged<int?> onChanged, int wattage) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0), // ใช้สีโทนนี้
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownButton<int>(
                    value: selectedValue,
                    onChanged: onChanged,
                    isExpanded: true,
                    items: List.generate(
                      10,
                      (index) => DropdownMenuItem<int>(
                        value: index,
                        child: Text(
                            '$index ${title.contains('แอร์') ? 'เครื่อง' : 'หลอด'}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // แสดงจำนวนวัตต์ต่อชั่วโมงทางด้านขวา
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$wattage',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF81C784), // ใช้สีโทนนี้
                      ),
                    ),
                    Text(
                      'วัตต์/ชั่วโมง',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Icon(
                      Icons.flash_on,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'พลังงานภายในที่อยู่อาศัย',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'หมวดหมู่ให้แสงสว่าง',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1), // ใช้สีโทนนี้
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildItemCard(
              'assets/images/light_led.png',
              'หลอดLED',
              selectedBulbs3,
              (value) {
                setState(() {
                  selectedBulbs3 = value!;
                  light3.text = '$value';
                });
              },
              light3Wattage, // ส่งค่า wattage สำหรับหลอด LED
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/light2.png',
              'หลอดตะเกียบ',
              selectedBulbs2,
              (value) {
                setState(() {
                  selectedBulbs2 = value!;
                  light2.text = '$value';
                });
              },
              light2Wattage, // ส่งค่า wattage สำหรับหลอดตะเกียบ
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/light.png',
              'หลอดไส้',
              selectedBulbs1,
              (value) {
                setState(() {
                  selectedBulbs1 = value!;
                  light1.text = '$value';
                });
              },
              light1Wattage, // ส่งค่า wattage สำหรับหลอดไส้
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'หมวดหมู่ให้แสงสว่าง',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1), // ใช้สีโทนนี้
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/fans.png',
              'พัดลมขนาดเล็ก',
              selectedBulbs8,
              (value) {
                setState(() {
                  selectedBulbs8 = value!;
                  fan_s.text = '$value';
                });
              },
              fansWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/fanb.png',
              'พัดลมขนาดใหญ่',
              selectedBulbs6,
              (value) {
                setState(() {
                  selectedBulbs6 = value!;
                  fan_b.text = '$value';
                });
              },
              fanbWattage, // ส่งค่า wattage สำหรับพัดลมขนาดใหญ่
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/airs.png',
              'แอร์ขนาดเล็ก',
              selectedBulbs5,
              (value) {
                setState(() {
                  selectedBulbs5 = value!;
                  air_s.text = '$value';
                });
              },
              airsWattage, // ส่งค่า wattage สำหรับแอร์ขนาดเล็ก
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/airb.png',
              'แอร์ขนาดใหญ่',
              selectedBulbs4,
              (value) {
                setState(() {
                  selectedBulbs4 = value!;
                  air_b.text = '$value';
                });
              },
              airbWattage, // ส่งค่า wattage สำหรับแอร์ขนาดใหญ่
            ),

            SizedBox(height: 20),
            Center(
              child: Text(
                'หมวดหมู่ทีวีและคอม',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1), // ใช้สีโทนนี้
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/laptop.png',
              'Laptop',
              selectedBulbs12,
              (value) {
                setState(() {
                  selectedBulbs12 = value!;
                  lab.text = '$value';
                });
              },
              labtopWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/tvled.png',
              'TV LED',
              selectedBulbs10,
              (value) {
                setState(() {
                  selectedBulbs10 = value!;
                  tvled.text = '$value';
                });
              },
              tvledWattage,
            ),

            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/tv.png',
              'TV',
              selectedBulbs7,
              (value) {
                setState(() {
                  selectedBulbs7 = value!;
                  tv.text = '$value';
                });
              },
              tvWattage,
            ),

            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/tvlcd.png',
              'TV LCD',
              selectedBulbs9,
              (value) {
                setState(() {
                  selectedBulbs9 = value!;
                  tvlcd.text = '$value';
                });
              },
              tvlcdWattage,
            ),

            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/com.png',
              'Computer',
              selectedBulbs11,
              (value) {
                setState(() {
                  selectedBulbs11 = value!;
                  com.text = '$value';
                });
              },
              comWattage,
            ),

            ///////////////////////////////////////////
            SizedBox(height: 20),
            Center(
              child: Text(
                'หมวดหมู่เครื่องใช้ในบ้านอื่นๆ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1), // ใช้สีโทนนี้
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/phone.png',
              'ที่ชาร์จ',
              selectedBulbs18,
              (value) {
                setState(() {
                  selectedBulbs18 = value!;
                  phone.text = '$value';
                });
              },
              phoneWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/fridgesz.png',
              'ตู้เย็น(เล็ก)',
              selectedBulbs20,
              (value) {
                setState(() {
                  selectedBulbs20 = value!;
                  fridgesz.text = '$value';
                });
              },
              fridgeszWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/fridge.png',
              'ตู้เย็น(ใหญ่)',
              selectedBulbs19,
              (value) {
                setState(() {
                  selectedBulbs19 = value!;
                  fridge.text = '$value';
                });
              },
              fridgeWattage,
            ),

            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/rice.png',
              'หม้อหุ้งข้าว',
              selectedBulbs14,
              (value) {
                setState(() {
                  selectedBulbs14 = value!;
                  rice.text = '$value';
                });
              },
              riceWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/washing.png',
              'เครื่องซักผ้า',
              selectedBulbs17,
              (value) {
                setState(() {
                  selectedBulbs17 = value!;
                  washing.text = '$value';
                });
              },
              washingWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/mic.png',
              'ไมโครเวฟ',
              selectedBulbs13,
              (value) {
                setState(() {
                  selectedBulbs13 = value!;
                  mic.text = '$value';
                });
              },
              micWattage,
            ),

            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/iron.png',
              'เตารีด',
              selectedBulbs15,
              (value) {
                setState(() {
                  selectedBulbs15 = value!;
                  iron.text = '$value';
                });
              },
              ironWattage,
            ),
            SizedBox(height: 20),
            _buildItemCard(
              'assets/images/waterh.png',
              'เครื่องทำน้ำอุ่น',
              selectedBulbs16,
              (value) {
                setState(() {
                  selectedBulbs16 = value!;
                  waterh.text = '$value';
                });
              },
              waterhWattage,
            ),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  update();
                    Navigator.pushNamed(
                      context,
                      'localhTime',
                      arguments: {
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
