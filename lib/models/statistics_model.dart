import 'package:json_annotation/json_annotation.dart';

part 'statistics_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StatisticsModel {
  @JsonKey(defaultValue: 0)
  final int totalZones;
  @JsonKey(defaultValue: 0)
  final int safeZones;
  @JsonKey(defaultValue: 0)
  final int unsafeZones;
  @JsonKey(defaultValue: 0)
  final int unknownZones;
  @JsonKey(defaultValue: 0)
  final int totalMines;
  @JsonKey(defaultValue: 0)
  final int totalReports;
  @JsonKey(defaultValue: 0)
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

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => _$StatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsModelToJson(this);
}

@JsonSerializable()
class MineTypeModel {
  final int id;
  final String name;
  final String description;

  MineTypeModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory MineTypeModel.fromJson(Map<String, dynamic> json) => _$MineTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$MineTypeModelToJson(this);
}
