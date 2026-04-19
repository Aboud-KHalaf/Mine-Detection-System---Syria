class ReportModel {
  final int id;
  final String reportType;
  final String? description;
  final String createdAt;

  ReportModel({
    required this.id,
    required this.reportType,
    this.description,
    required this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as int,
      reportType: json['report_type'] as String,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_type': reportType,
      'description': description,
      'created_at': createdAt,
    };
  }
}
