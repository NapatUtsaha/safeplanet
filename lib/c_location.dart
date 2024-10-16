class LoData {
  final int id;
  final String location;
  final String email;

  LoData({
    required this.id,
    required this.location,
 required this.email,
  });

  factory LoData.fromJson(Map<String, dynamic> json) {
    return LoData(
      id: int.parse(
          json['lo_id'].toString()), // แปลงค่า id_u จาก dynamic เป็น int
      // แปลงค่า sumCarbon จาก dynamic เป็น double
      location: json['location_name'],
      email: json['email'], // ตรวจสอบและกำหนดค่าเริ่มต้นให้ type
    );
  }
}
