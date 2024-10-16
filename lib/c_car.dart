class CarData {
  final int id_c;
  final String typeCar;
  final int huCount;
  final double disCount;
  final double totalCO2;
  final String date;
  final String time;

  CarData({
    required this.id_c,
    required this.typeCar,
    required this.huCount,
    required this.disCount,
    required this.totalCO2,
    required this.date,
    required this.time,
  });

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
      id_c: int.parse(json['id_c']),
      typeCar: json['typeCar'],
      huCount: int.parse(json['huCount']),
      disCount: double.parse(json['disCount']),
      totalCO2: double.parse(json['totalCO2']),
      date: json['date'],
      time: json['time'],
    );
  }
}
