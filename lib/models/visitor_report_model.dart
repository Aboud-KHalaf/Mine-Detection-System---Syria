class VisitorReportModel {
  final int id;
  final String fullName;
  final String phone;
  final List<double> coordinates;
  final String? image;
  final String? imageUrl;
  final String? notes;
  final bool confirmed;
  final String createdAt;

  VisitorReportModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.coordinates,
    this.image,
    this.imageUrl,
    this.notes,
    required this.confirmed,
    required this.createdAt,
  });

  factory VisitorReportModel.fromJson(Map<String, dynamic> json) {
    return VisitorReportModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      coordinates: (json['coordinates'] as List).map((e) => (e as num).toDouble()).toList(),
      image: json['image'] as String?,
      imageUrl: json['image_url'] as String?,
      notes: json['notes'] as String?,
      confirmed: json['confirmed'] as bool? ?? false,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'coordinates': coordinates,
      'image': image,
      'image_url': imageUrl,
      'notes': notes,
      'confirmed': confirmed,
      'created_at': createdAt,
    };
  }
}
