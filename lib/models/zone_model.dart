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
    required this.shapeType,
    this.shapeRadius,
    this.coordinates,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      statusDisplay: json['status_display'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      createdBy: json['created_by'] as String?,
      minesCount: json['mines_count'] as int?,
      estimatedArea: (json['estimated_area'] as num?)?.toDouble(),
      shapeType: json['shape_type'] as String? ?? 'polygon',
      shapeRadius: (json['shape_radius'] as num?)?.toDouble(),
      coordinates: json['coordinates'] as Map<String, dynamic>?,
    );
  }

  /// Parses from the GeoJSON feature properties & geometry when calling GET /zones/
  factory ZoneModel.fromFeature(Map<String, dynamic> feature) {
    final properties = feature['properties'] as Map<String, dynamic>;
    final geometry = feature['geometry'] as Map<String, dynamic>?;
    return ZoneModel.fromJson({
      ...properties,
      'coordinates': geometry,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'status_display': statusDisplay,
      'description': description,
      'created_at': createdAt,
      'created_by': createdBy,
      'mines_count': minesCount,
      'estimated_area': estimatedArea,
      'shape_type': shapeType,
      'shape_radius': shapeRadius,
      'coordinates': coordinates,
    };
  }
}
