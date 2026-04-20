import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}
