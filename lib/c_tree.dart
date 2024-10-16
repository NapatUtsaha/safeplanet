class TreeData {
  final int id_t;
  final String treeType;
  final int treeCount;
  final double ReduceCO2;
  final String userEmail;
  final String date;
  final String time;

  TreeData({
    required this.id_t,
    required this.treeType,
    required this.treeCount,
    required this.ReduceCO2,
    required this.userEmail,
    required this.date,
    required this.time,
  });

  factory TreeData.fromJson(Map<String, dynamic> json) {
    return TreeData(
      id_t: int.tryParse(json['id_t'].toString()) ?? 0,
      treeType: json['treeType'] ?? '',
      treeCount: int.tryParse(json['treeCount'].toString()) ?? 0,
      ReduceCO2: double.tryParse(json['ReduceCO2'].toString()) ?? 0.0,
      userEmail: json['userEmail'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
