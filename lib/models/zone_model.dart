import 'package:json_annotation/json_annotation.dart';

part 'zone_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ZoneModel {
  final int id;
  final String name;
  final String status;
  final String? statusDisplay;
  final String? description;
  final String? createdAt;
  final String? createdBy;
  final int? minesCount;
  final double? estimatedArea;
  final String shapeType;
  final double? shapeRadius;
  final Map<String, dynamic>? coordinates;

  ZoneModel({
    required this.id,
    required this.name,
    required this.status,
    this.statusDisplay,
    this.description,
    this.createdAt,
    this.createdBy,
    this.minesCount,
    this.estimatedArea,
    this.shapeType = 'polygon',
    this.shapeRadius,
    this.coordinates,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) => _$ZoneModelFromJson(json);
  /// Parses from the GeoJSON feature properties & geometry when calling GET /zones/
  factory ZoneModel.fromFeature(Map<String, dynamic> feature) {
    final properties = feature['properties'] as Map<String, dynamic>;
    final geometry = feature['geometry'] as Map<String, dynamic>?;
    return ZoneModel.fromJson({
      ...properties,
      'coordinates': geometry,
    });
  }

  Map<String, dynamic> toJson() => _$ZoneModelToJson(this);
}
