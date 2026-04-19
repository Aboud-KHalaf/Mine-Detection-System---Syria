class StatisticsModel {
  final int totalZones;
  final int safeZones;
  final int unsafeZones;
  final int unknownZones;
  final int totalMines;
  final int totalReports;
  final int visitorReports;

  StatisticsModel({
    required this.totalZones,
    required this.safeZones,
    required this.unsafeZones,
    required this.unknownZones,
    required this.totalMines,
    required this.totalReports,
    required this.visitorReports,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalZones: json['total_zones'] as int? ?? 0,
      safeZones: json['safe_zones'] as int? ?? 0,
      unsafeZones: json['unsafe_zones'] as int? ?? 0,
      unknownZones: json['unknown_zones'] as int? ?? 0,
      totalMines: json['total_mines'] as int? ?? 0,
      totalReports: json['total_reports'] as int? ?? 0,
      visitorReports: json['visitor_reports'] as int? ?? 0,
    );
  }
}

class MineTypeModel {
  final int id;
  final String name;
  final String description;

  MineTypeModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory MineTypeModel.fromJson(Map<String, dynamic> json) {
    return MineTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}
