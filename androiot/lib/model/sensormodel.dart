class SensorModel {
  final double jarak;

  SensorModel({
    required this.jarak,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      jarak: json['jarak']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jarak': jarak,
    };
  }
}
