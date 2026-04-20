// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
  id: (json['id'] as num).toInt(),
  reportType: json['report_type'] as String,
  description: json['description'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'report_type': instance.reportType,
      'description': instance.description,
      'created_at': instance.createdAt,
    };
