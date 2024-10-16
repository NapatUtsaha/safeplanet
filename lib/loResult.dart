import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class loResult extends StatefulWidget {
  final String? location;
  final String? email;

  const loResult({Key? key, this.location, this.email}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<loResult> {
  Map<String, dynamic>? data;
  List<Map<String, dynamic>> carbonData = [];
  final formkey = GlobalKey<FormState>();

  // กำหนดตัวแปรสำหรับเก็บค่าของแต่ละช่อง
  int? id_u;
  int? light1Value;
  int? light1HValue;
  int? light1MValue;
  int? light2Value;
  int? light2HValue;
  int? light2MValue;
  int? light3Value;
  int? light3HValue;
  int? light3MValue;
  int? airBValue;
  int? airBHValue;
  int? airBMValue;
  int? airSValue;
  int? airSHValue;
  int? airSMValue;
  int? fanBValue;
  int? fanBHValue;
  int? fanBMValue;
  int? fanSValue;
  int? fanSHValue;
  int? fanSMValue;
  int? tvValue;
  int? tvHValue;
  int? tvMValue;
  int? tvlcdValue;
  int? tvlcdHValue;
  int? tvlcdMValue;
  int? tvledValue;
  int? tvledHValue;
  int? tvledMValue;
  int? comValue;
  int? comHValue;
  int? comMValue;
  int? labValue;
  int? labHValue;
  int? labMValue;
  int? riceValue;
  int? riceHValue;
  int? riceMValue;
  int? micValue;
  int? micHValue;
  int? micMValue;
  int? ironValue;
  int? ironHValue;
  int? ironMValue;
  int? waterhValue;
  int? waterhHValue;
  int? waterhMValue;
  int? washingValue;
  int? washingHValue;
  int? washingMValue;
  int? phoneValue;
  int? phoneHValue;
  int? phoneMValue;
  int? fridgeValue;
  int? fridgeHValue;
  int? fridgeMValue;
  int? fridgeszValue;
  int? fridgeszHValue;
  int? fridgeszMValue;
  String? userEmail;
  String home = 'home';
  String? location;

  final double carbonEmissionFactor = 0.5;

  final int light1Wattage = 60;
  final int light2Wattage = 15;
  final int light3Wattage = 10;

  final int airbWattage = 3000; // 3 kW
  final int airsWattage = 1500; // 1.5 kW

  final int fanbWattage = 75; // วัตต์
  final int fansWattage = 30; // วัตต์

  final int tvWattage = 200; // วัตต์
  final int tvlcdWattage = 250; // วัตต์
  final int tvledWattage = 150; // วัตต์

  final int comWattage = 300;
  final int labtopWattage = 100;

  final int riceWattage = 500;
  final int micWattage = 1150;
  final int ironWattage = 1500;
  final int waterhWattage = 3000;
  final int washingWattage = 750;
  final int phoneWattage = 20;
  final int fridgeWattage = 200;
  final int fridgeszWattage = 100;

  double get light1CarbonFootprint => calculateCarbonFootprint(light1Value,
      light1HValue, light1MValue, light1Wattage, carbonEmissionFactor);

  double get light3CarbonFootprint => calculateCarbonFootprint(light3Value,
      light3HValue, light3MValue, light3Wattage, carbonEmissionFactor);

  double get light2CarbonFootprint => calculateCarbonFootprint(light2Value,
      light2HValue, light2MValue, light2Wattage, carbonEmissionFactor);

  double get airbCarbonFootprint => calculateCarbonFootprint(
      airBValue, airBHValue, airBMValue, airbWattage, carbonEmissionFactor);

  double get airsCarbonFootprint => calculateCarbonFootprint(
      airSValue, airSHValue, airSMValue, airsWattage, carbonEmissionFactor);

  double get fanbCarbonFootprint => calculateCarbonFootprint(
      fanBValue, fanBHValue, fanBMValue, fanbWattage, carbonEmissionFactor);

  double get fansCarbonFootprint => calculateCarbonFootprint(
      fanSValue, fanSHValue, fanSMValue, fansWattage, carbonEmissionFactor);

  double get tvCarbonFootprint => calculateCarbonFootprint(
      tvValue, tvHValue, tvMValue, tvWattage, carbonEmissionFactor);

  double get tvlcdCarbonFootprint => calculateCarbonFootprint(
      tvlcdValue, tvlcdHValue, tvlcdMValue, tvlcdWattage, carbonEmissionFactor);

  double get tvledCarbonFootprint => calculateCarbonFootprint(
      tvledValue, tvledHValue, tvledMValue, tvledWattage, carbonEmissionFactor);

  double get comCarbonFootprint => calculateCarbonFootprint(
      comValue, comHValue, comMValue, comWattage, carbonEmissionFactor);

  double get labtopCarbonFootprint => calculateCarbonFootprint(
      labValue, labHValue, labMValue, labtopWattage, carbonEmissionFactor);

  double get riceCarbonFootprint => calculateCarbonFootprint(
      riceValue, riceHValue, riceMValue, riceWattage, carbonEmissionFactor);

  double get micCarbonFootprint => calculateCarbonFootprint(
      micValue, micHValue, micMValue, micWattage, carbonEmissionFactor);

  double get ironCarbonFootprint => calculateCarbonFootprint(
      ironValue, ironHValue, ironMValue, ironWattage, carbonEmissionFactor);

  double get waterhCarbonFootprint => calculateCarbonFootprint(waterhValue,
      waterhHValue, waterhMValue, waterhWattage, carbonEmissionFactor);

  double get washingCarbonFootprint => calculateCarbonFootprint(washingValue,
      washingHValue, washingMValue, washingWattage, carbonEmissionFactor);

  double get phoneCarbonFootprint => calculateCarbonFootprint(
      phoneValue, phoneHValue, phoneMValue, phoneWattage, carbonEmissionFactor);

  double get fridgeCarbonFootprint => calculateCarbonFootprint(fridgeValue,
      fridgeHValue, fridgeMValue, fridgeWattage, carbonEmissionFactor);

  double get fridgeszCarbonFootprint => calculateCarbonFootprint(fridgeszValue,
      fridgeszHValue, fridgeszMValue, fridgeszWattage, carbonEmissionFactor);

  double get sumCarbon =>
      light1CarbonFootprint +
      light2CarbonFootprint +
      light3CarbonFootprint +
      airbCarbonFootprint +
      airsCarbonFootprint +
      fanbCarbonFootprint +
      fansCarbonFootprint +
      tvCarbonFootprint +
      tvlcdCarbonFootprint +
      tvledCarbonFootprint +
      comCarbonFootprint +
      labtopCarbonFootprint +
      riceCarbonFootprint +
      micCarbonFootprint +
      ironCarbonFootprint +
      waterhCarbonFootprint +
      washingCarbonFootprint +
      phoneCarbonFootprint +
      fridgeCarbonFootprint +
      fridgeszCarbonFootprint;

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
      setState(() {
        data = json.decode(response.body);

        // พิมพ์ข้อมูลที่ดึงมาเพื่อตรวจสอบว่าได้รับข้อมูลหรือไม่
        print('Fetched data: $data');
        print('Data: ${data.toString()}');
        // เก็บค่าของแต่ละช่องในตัวแปรที่กำหนดไว้
        if (data != null) {
          id_u = int.tryParse(data!['id_u']?.toString() ?? '0');
          light1Value = int.tryParse(data!['light1']?.toString() ?? '0');
          light1HValue = int.tryParse(data!['light1_h']?.toString() ?? '0');
          light1MValue = int.tryParse(data!['light1_m']?.toString() ?? '0');
          light2Value = int.tryParse(data!['light2']?.toString() ?? '0');
          light2HValue = int.tryParse(data!['light2_h']?.toString() ?? '0');
          light2MValue = int.tryParse(data!['light2_m']?.toString() ?? '0');
          light3Value = int.tryParse(data!['light3']?.toString() ?? '0');
          light3HValue = int.tryParse(data!['light3_h']?.toString() ?? '0');
          light3MValue = int.tryParse(data!['light3_m']?.toString() ?? '0');
          airBValue = int.tryParse(data!['air_b']?.toString() ?? '0');
          airBHValue = int.tryParse(data!['air_b_h']?.toString() ?? '0');
          airBMValue = int.tryParse(data!['air_b_m']?.toString() ?? '0');
          airSValue = int.tryParse(data!['air_s']?.toString() ?? '0');
          airSHValue = int.tryParse(data!['air_s_h']?.toString() ?? '0');
          airSMValue = int.tryParse(data!['air_s_m']?.toString() ?? '0');
          fanBValue = int.tryParse(data!['fan_b']?.toString() ?? '0');
          fanBHValue = int.tryParse(data!['fan_b_h']?.toString() ?? '0');
          fanBMValue = int.tryParse(data!['fan_b_m']?.toString() ?? '0');
          fanSValue = int.tryParse(data!['fan_s']?.toString() ?? '0');
          fanSHValue = int.tryParse(data!['fan_s_h']?.toString() ?? '0');
          fanSMValue = int.tryParse(data!['fan_s_m']?.toString() ?? '0');
          tvValue = int.tryParse(data!['tv']?.toString() ?? '0');
          tvHValue = int.tryParse(data!['tv_h']?.toString() ?? '0');
          tvMValue = int.tryParse(data!['tv_m']?.toString() ?? '0');
          tvlcdValue = int.tryParse(data!['tvlcd']?.toString() ?? '0');
          tvlcdHValue = int.tryParse(data!['tvlcd_h']?.toString() ?? '0');
          tvlcdMValue = int.tryParse(data!['tvlcd_m']?.toString() ?? '0');
          tvledValue = int.tryParse(data!['tvled']?.toString() ?? '0');
          tvledHValue = int.tryParse(data!['tvled_h']?.toString() ?? '0');
          tvledMValue = int.tryParse(data!['tvled_m']?.toString() ?? '0');
          comValue = int.tryParse(data!['com']?.toString() ?? '0');
          comHValue = int.tryParse(data!['com_h']?.toString() ?? '0');
          comMValue = int.tryParse(data!['com_m']?.toString() ?? '0');
          labValue = int.tryParse(data!['lab']?.toString() ?? '0');
          labHValue = int.tryParse(data!['lab_h']?.toString() ?? '0');
          labMValue = int.tryParse(data!['lab_m']?.toString() ?? '0');
          riceValue = int.tryParse(data!['rice']?.toString() ?? '0');
          riceHValue = int.tryParse(data!['rice_h']?.toString() ?? '0');
          riceMValue = int.tryParse(data!['rice_m']?.toString() ?? '0');
          micValue = int.tryParse(data!['mic']?.toString() ?? '0');
          micHValue = int.tryParse(data!['mic_h']?.toString() ?? '0');
          micMValue = int.tryParse(data!['mic_m']?.toString() ?? '0');
          ironValue = int.tryParse(data!['iron']?.toString() ?? '0');
          ironHValue = int.tryParse(data!['iron_h']?.toString() ?? '0');
          ironMValue = int.tryParse(data!['iron_m']?.toString() ?? '0');
          waterhValue = int.tryParse(data!['waterh']?.toString() ?? '0');
          waterhHValue = int.tryParse(data!['waterh_h']?.toString() ?? '0');
          waterhMValue = int.tryParse(data!['waterh_m']?.toString() ?? '0');
          washingValue = int.tryParse(data!['washing']?.toString() ?? '0');
          washingHValue = int.tryParse(data!['washing_h']?.toString() ?? '0');
          washingMValue = int.tryParse(data!['washing_m']?.toString() ?? '0');
          phoneValue = int.tryParse(data!['phone']?.toString() ?? '0');
          phoneHValue = int.tryParse(data!['phone_h']?.toString() ?? '0');
          phoneMValue = int.tryParse(data!['phone_m']?.toString() ?? '0');
          fridgeValue = int.tryParse(data!['fridge']?.toString() ?? '0');
          fridgeHValue = int.tryParse(data!['fridge_h']?.toString() ?? '0');
          fridgeMValue = int.tryParse(data!['fridge_m']?.toString() ?? '0');
          fridgeszValue = int.tryParse(data!['fridgesz']?.toString() ?? '0');
          fridgeszHValue = int.tryParse(data!['fridgesz_h']?.toString() ?? '0');
          fridgeszMValue = int.tryParse(data!['fridgesz_m']?.toString() ?? '0');
          userEmail = data!['userEmail']?.toString() ?? '0';
          location = data!['location']?.toString() ?? '0';

          // พิมพ์ค่าของแต่ละตัวแปรเพื่อตรวจสอบ
          print('id_u : $id_u');
          print('email : $userEmail');
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> insert(sumCarbon) async {
    String url = "http://172.20.10.2/flutter_login/upResult.php";
    try {
      final response = await http.post(Uri.parse(url), body: {
        'id_u': id_u.toString(),
        'sumCarbon': sumCarbon.toString(),
        'email': userEmail,
        'type': home,
      });

      var data = json.decode(response.body);
      if (data == "Succeed") {
        print('Insertion succeeded');
      } else if (data == "Failed to insert data") {
        print('Failed to insert data');
      } else {
        print('Unexpected response: $data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error here, such as showing a snackbar or dialog
    }
  }

  List<PieChartSectionData> _generatePieChartSections() {
    double totalFootprint = light1CarbonFootprint +
        light2CarbonFootprint +
        light3CarbonFootprint +
        airbCarbonFootprint +
        airsCarbonFootprint +
        fanbCarbonFootprint +
        fansCarbonFootprint +
        tvCarbonFootprint +
        tvlcdCarbonFootprint +
        tvledCarbonFootprint +
        comCarbonFootprint +
        labtopCarbonFootprint +
        riceCarbonFootprint +
        micCarbonFootprint +
        ironCarbonFootprint +
        waterhCarbonFootprint +
        washingCarbonFootprint +
        phoneCarbonFootprint +
        fridgeCarbonFootprint +
        fridgeszCarbonFootprint;

    return [
      PieChartSectionData(
        color: Colors.yellow[100], // สีเหลืองพาสเทล สำหรับหลอดไส้
        value: light1CarbonFootprint / totalFootprint * 100,
        title: 'หลอดไส้',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.yellow[200], // สีเหลืองพาสเทล สำหรับหลอดตะเกียบ
        value: light2CarbonFootprint / totalFootprint * 100,
        title: 'หลอดตะเกียบ',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.yellow[300], // สีเหลืองพาสเทล สำหรับหลอด LED
        value: light3CarbonFootprint / totalFootprint * 100,
        title: 'หลอด LED',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.blue[100], // สีฟ้าพาสเทล สำหรับแอร์ขนาดใหญ่
        value: airbCarbonFootprint / totalFootprint * 100,
        title: 'แอร์ขนาดใหญ่',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.blue[200], // สีฟ้าพาสเทล สำหรับแอร์ขนาดเล็ก
        value: airsCarbonFootprint / totalFootprint * 100,
        title: 'แอร์ขนาดเล็ก',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.green[100], // สีเขียวพาสเทล สำหรับพัดลมขนาดใหญ่
        value: fanbCarbonFootprint / totalFootprint * 100,
        title: 'พัดลมขนาดใหญ่',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.green[200], // สีเขียวพาสเทล สำหรับพัดลมขนาดเล็ก
        value: fansCarbonFootprint / totalFootprint * 100,
        title: 'พัดลมขนาดเล็ก',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.grey[100], // สีเทาพาสเทล สำหรับทีวี
        value: tvCarbonFootprint / totalFootprint * 100,
        title: 'ทีวี',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.grey[200], // สีเทาพาสเทล สำหรับทีวี LCD
        value: tvlcdCarbonFootprint / totalFootprint * 100,
        title: 'ทีวี LCD',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.grey[300], // สีเทาพาสเทล สำหรับทีวี LED
        value: tvledCarbonFootprint / totalFootprint * 100,
        title: 'ทีวี LED',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.red[100], // สีแดงพาสเทล สำหรับคอมพิวเตอร์
        value: comCarbonFootprint / totalFootprint * 100,
        title: 'คอมพิวเตอร์',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.red[200], // สีแดงพาสเทล สำหรับโน้ตบุ๊ก
        value: labtopCarbonFootprint / totalFootprint * 100,
        title: 'โน้ตบุ๊ก',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.brown[100], // สีน้ำตาลพาสเทล สำหรับหม้อหุงข้าว
        value: riceCarbonFootprint / totalFootprint * 100,
        title: 'หม้อหุงข้าว',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.purple[100], // สีม่วงพาสเทล สำหรับไมโครเวฟ
        value: micCarbonFootprint / totalFootprint * 100,
        title: 'ไมโครเวฟ',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.orange[100], // สีส้มพาสเทล สำหรับเตารีด
        value: ironCarbonFootprint / totalFootprint * 100,
        title: 'เตารีด',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.orange[200], // สีส้มพาสเทล สำหรับเครื่องทำน้ำอุ่น
        value: waterhCarbonFootprint / totalFootprint * 100,
        title: 'เครื่องทำน้ำอุ่น',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.pink[100], // สีชมพูพาสเทล สำหรับเครื่องซักผ้า
        value: washingCarbonFootprint / totalFootprint * 100,
        title: 'เครื่องซักผ้า',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.pink[200], // สีชมพูพาสเทล สำหรับที่ชาร์จแบต
        value: phoneCarbonFootprint / totalFootprint * 100,
        title: 'ที่ชาร์จแบต',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.blueGrey[100], // สีเทาอมฟ้าพาสเทล สำหรับตู้เย็นขนาดใหญ่
        value: fridgeCarbonFootprint / totalFootprint * 100,
        title: 'ตู้เย็นขนาดใหญ่',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.blueGrey[200], // สีเทาอมฟ้าพาสเทล สำหรับตู้เย็นขนาดเล็ก
        value: fridgeszCarbonFootprint / totalFootprint * 100,
        title: 'ตู้เย็นขนาดเล็ก',
        radius: 50,
      ),

      // Add more PieChartSectionData for each appliance
    ];
  }

  List<Widget> _buildSortedCarbonFootprints() {
    // สร้างลิสต์ของข้อมูลคาร์บอน
    List<Map<String, double>> carbonFootprints = [
      if (light1Value != null && light1Value != 0)
        {'หลอดไส้': light1CarbonFootprint / sumCarbon * 100},
      if (light2Value != null && light2Value != 0)
        {'หลอดตะเกียบ': light2CarbonFootprint / sumCarbon * 100},
      if (light3Value != null && light3Value != 0)
        {'หลอด LED': light3CarbonFootprint / sumCarbon * 100},
      if (airBValue != null && airBValue != 0)
        {'แอร์ขนาดใหญ่': airbCarbonFootprint / sumCarbon * 100},
      if (airSValue != null && airSValue != 0)
        {'แอร์ขนาดเล็ก': airsCarbonFootprint / sumCarbon * 100},
      if (fanBValue != null && fanBValue != 0)
        {'พัดลมขนาดใหญ่': fanbCarbonFootprint / sumCarbon * 100},
      if (fanSValue != null && fanSValue != 0)
        {'พัดลมขนาดเล็ก': fansCarbonFootprint / sumCarbon * 100},
      if (tvValue != null && tvValue != 0)
        {'ทีวี': tvCarbonFootprint / sumCarbon * 100},
      if (tvlcdValue != null && tvlcdValue != 0)
        {'ทีวี LCD': tvlcdCarbonFootprint / sumCarbon * 100},
      if (tvledValue != null && tvledValue != 0)
        {'ทีวี LED': tvledCarbonFootprint / sumCarbon * 100},
      if (comValue != null && comValue != 0)
        {'คอมพิวเตอร์': comCarbonFootprint / sumCarbon * 100},
      if (labValue != null && labValue != 0)
        {'โน้ตบุ้ค': labtopCarbonFootprint / sumCarbon * 100},
      if (riceValue != null && riceValue != 0)
        {'หม้อหุงข้าว': riceCarbonFootprint / sumCarbon * 100},
      if (micValue != null && micValue != 0)
        {'ไมโครเวฟ': micCarbonFootprint / sumCarbon * 100},
      if (ironValue != null && ironValue != 0)
        {'เตารีด': ironCarbonFootprint / sumCarbon * 100},
      if (waterhValue != null && waterhValue != 0)
        {'เครื่องทำน้ำอุ่น': waterhCarbonFootprint / sumCarbon * 100},
      if (washingValue != null && washingValue != 0)
        {'เครื่องซักผ้า': washingCarbonFootprint / sumCarbon * 100},
      if (phoneValue != null && phoneValue != 0)
        {'ที่ชาร์จแบต': phoneCarbonFootprint / sumCarbon * 100},
      if (fridgeValue != null && fridgeValue != 0)
        {'ตู้เย็นขนาดใหญ่': fridgeCarbonFootprint / sumCarbon * 100},
      if (fridgeszValue != null && fridgeszValue != 0)
        {'ตู้เย็นขนาดเล็ก': fridgeszCarbonFootprint / sumCarbon * 100},
    ];

    // จัดเรียงลิสต์ตามค่าเปอร์เซ็นต์จากมากไปน้อย
    carbonFootprints.sort((a, b) => b.values.first.compareTo(a.values.first));

    // สร้างลิสต์ของ Text widgets ตามลำดับ
    List<Widget> sortedWidgets = carbonFootprints.map((map) {
      final entry = map.entries.first;
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50], // สีพื้นหลังที่ดูสดใสขึ้น
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              entry.key,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[800]), // เปลี่ยนสีข้อความ
            ),
            Text(
              '${entry.value.toStringAsFixed(2)}%',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal[600]), // เปลี่ยนสีข้อความ
            ),
          ],
        ),
      );
    }).toList();

    return sortedWidgets;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  double calculateCarbonFootprint(int? numBulbs, int? hours, int? minutes,
      int wattage, double carbonEmissionFactor) {
    if (numBulbs == null || hours == null || minutes == null) {
      return 0.0;
    }
    // รวมเวลาทั้งหมดในชั่วโมง
    double totalHours = hours + (minutes / 60);
    // การใช้พลังงานต่อวัน (kWh)
    double energyConsumptionPerDay = (numBulbs * wattage * totalHours) / 1000;
    // คำนวณค่าคาร์บอนฟุตพริ้นต์ต่อวัน (kg CO2)
    double carbonFootprintPerDay =
        energyConsumptionPerDay * carbonEmissionFactor;
    return carbonFootprintPerDay;
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
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            data != null
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(
                        'ปริมาณการปล่อยก๊าซเรือนกระจก',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${sumCarbon.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF44336),
                        ),
                      ),
                      Text(
                        'กิโลกรัม CO2e',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFF44336),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment
                            .center, // จัดตำแหน่งกล่องให้อยู่กลางหน้าจอ
                        child: SizedBox(
                          width: 250, // กำหนดความกว้างของกล่องตามต้องการ
                          child: Container(
                            padding: EdgeInsets.all(
                                16.0), // เพิ่ม padding ข้างในกล่อง
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 176, 48, 38), // กำหนดสีพื้นหลังเป็นสีแดง
                              borderRadius: BorderRadius.circular(
                                  10.0), // กำหนดความโค้งมนของมุม
                            ),
                            child: Center(
                              child: Text(
                                'สถานที่ : $location',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Colors.white, // กำหนดสีตัวอักษรเป็นสีขาว
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PieChart(
                              PieChartData(
                                sections: _generatePieChartSections(),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,
                                centerSpaceRadius: 60,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
            SizedBox(height: 20),
            Text(
              'ค่าคาร์บอนแต่ละชนิด',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              height: 300, // กำหนดความสูงของกล่องที่สามารถเลื่อนขึ้นลงได้
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildSortedCarbonFootprints(),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'home',
                      arguments: userEmail,
                    );
                  },
                  icon: Icon(Icons.home),
                  label: Text('กลับหน้าแรก'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFF44336),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    insert(sumCarbon);
                    Navigator.pushNamed(
                      context,
                      'home',
                      arguments: userEmail,
                    );
                  },
                  icon: Icon(Icons.save),
                  label: Text('บันทึก'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 159, 203, 103),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
