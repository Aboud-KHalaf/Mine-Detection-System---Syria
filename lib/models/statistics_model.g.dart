// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) =>
    StatisticsModel(
      totalZones: (json['total_zones'] as num?)?.toInt() ?? 0,
      safeZones: (json['safe_zones'] as num?)?.toInt() ?? 0,
      unsafeZones: (json['unsafe_zones'] as num?)?.toInt() ?? 0,
      unknownZones: (json['unknown_zones'] as num?)?.toInt() ?? 0,
      totalMines: (json['total_mines'] as num?)?.toInt() ?? 0,
      totalReports: (json['total_reports'] as num?)?.toInt() ?? 0,
      visitorReports: (json['visitor_reports'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) =>
    <String, dynamic>{
      'total_zones': instance.totalZones,
      'safe_zones': instance.safeZones,
      'unsafe_zones': instance.unsafeZones,
      'unknown_zones': instance.unknownZones,
      'total_mines': instance.totalMines,
      'total_reports': instance.totalReports,
      'visitor_reports': instance.visitorReports,
    };

MineTypeModel _$MineTypeModelFromJson(Map<String, dynamic> json) =>
    MineTypeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MineTypeModelToJson(MineTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
