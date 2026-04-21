import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

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

  /// Extract LatLng points for rendering polygons
  List<List<LatLng>> get getPolygonPoints {
    if (coordinates == null || coordinates!['type'] != 'Polygon') return [];
    
    final rings = coordinates!['coordinates'] as List<dynamic>;
    return rings.map((ring) {
      return (ring as List<dynamic>).map((point) {
        // GeoJSON uses [longitude, latitude]
        return LatLng(
          (point[1] as num).toDouble(),
          (point[0] as num).toDouble(),
        );
      }).toList();
    }).toList();
  }

  /// Extract LatLng for circle centers
  LatLng? get getCircleCenter {
    if (coordinates == null || coordinates!['type'] != 'Point') return null;
    
    final coords = coordinates!['coordinates'] as List<dynamic>;
    // GeoJSON uses [longitude, latitude]
    return LatLng(
      (coords[1] as num).toDouble(),
      (coords[0] as num).toDouble(),
    );
  }

  /// Returns a color representing the zone's danger level
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'safe':
        return Colors.green;
      case 'unsafe':
        return Colors.red;
      case 'unknown':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

