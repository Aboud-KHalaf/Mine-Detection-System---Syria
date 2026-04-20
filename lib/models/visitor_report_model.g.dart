// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorReportModel _$VisitorReportModelFromJson(Map<String, dynamic> json) =>
    VisitorReportModel(
      id: (json['id'] as num).toInt(),
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String?,
      notes: json['notes'] as String?,
      confirmed: json['confirmed'] as bool? ?? false,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$VisitorReportModelToJson(VisitorReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'coordinates': instance.coordinates,
      'image': instance.image,
      'image_url': instance.imageUrl,
      'notes': instance.notes,
      'confirmed': instance.confirmed,
      'created_at': instance.createdAt,
    };
