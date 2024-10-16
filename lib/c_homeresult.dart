class CarbonData {
  final int id;
  final double sumCarbon;
  final String email;
  final String date;
  final String time;
  final String type;

  CarbonData({
    required this.id,
    required this.sumCarbon,
    required this.email,
    required this.date,
    required this.time,
    required this.type,
  });

  factory CarbonData.fromJson(Map<String, dynamic> json) {
    return CarbonData(
      id: int.parse(
          json['id_u'].toString()), // แปลงค่า id_u จาก dynamic เป็น int
      sumCarbon: double.parse(json['sumCarbon']
          .toString()), // แปลงค่า sumCarbon จาก dynamic เป็น double
      email: json['email'],
      date: json['date'],
      time: json['time'],
      type: json['type'] ?? '', // ตรวจสอบและกำหนดค่าเริ่มต้นให้ type
    );
  }
}
