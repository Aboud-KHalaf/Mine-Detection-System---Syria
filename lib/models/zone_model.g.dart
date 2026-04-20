// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneModel _$ZoneModelFromJson(Map<String, dynamic> json) => ZoneModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: json['status'] as String,
  statusDisplay: json['status_display'] as String?,
  description: json['description'] as String?,
  createdAt: json['created_at'] as String?,
  createdBy: json['created_by'] as String?,
  minesCount: (json['mines_count'] as num?)?.toInt(),
  estimatedArea: (json['estimated_area'] as num?)?.toDouble(),
  shapeType: json['shape_type'] as String? ?? 'polygon',
  shapeRadius: (json['shape_radius'] as num?)?.toDouble(),
  coordinates: json['coordinates'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ZoneModelToJson(ZoneModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
  'status_display': instance.statusDisplay,
  'description': instance.description,
  'created_at': instance.createdAt,
  'created_by': instance.createdBy,
  'mines_count': instance.minesCount,
  'estimated_area': instance.estimatedArea,
  'shape_type': instance.shapeType,
  'shape_radius': instance.shapeRadius,
  'coordinates': instance.coordinates,
};
