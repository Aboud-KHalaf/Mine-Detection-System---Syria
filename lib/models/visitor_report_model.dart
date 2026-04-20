import 'package:json_annotation/json_annotation.dart';

part 'visitor_report_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VisitorReportModel {
  final int id;
  final String fullName;
  final String phone;
  final List<double> coordinates;
  final String? image;
  final String? imageUrl;
  final String? notes;
  @JsonKey(defaultValue: false)
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

  factory VisitorReportModel.fromJson(Map<String, dynamic> json) => _$VisitorReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorReportModelToJson(this);
}
