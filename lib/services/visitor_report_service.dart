import 'dart:io';

import '../core/api_client.dart';
import '../models/visitor_report_model.dart';
import 'api/visitor_report_api.dart';

class VisitorReportService {
  final ApiClient apiClient;
  final VisitorReportApi _visitorReportApi;

  VisitorReportService(this.apiClient) : _visitorReportApi = VisitorReportApi(apiClient.dio);

  Future<void> submitVisitorReport({
    required String fullName,
    required String phone,
    required List<double> coordinates,
    String? notes,
    String? imagePath,
  }) async {
    final imgFile = imagePath != null ? File(imagePath) : null;
    await _visitorReportApi.submitVisitorReport(
      fullName,
      phone,
      '${coordinates[0]},${coordinates[1]}',
      notes,
      imgFile,
    );
  }

  Future<List<VisitorReportModel>> getVisitorReports() async {
    final response = await _visitorReportApi.getVisitorReports();
    final List<dynamic> reports = response['reports'] ?? [];
    return reports.map((e) => VisitorReportModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<VisitorReportModel> getVisitorReportDetails(int id) async {
    return await _visitorReportApi.getVisitorReportDetails(id);
  }

  Future<void> deleteVisitorReport(int id) async {
    await _visitorReportApi.deleteVisitorReport(id);
  }

  Future<void> confirmVisitorReport(int id) async {
    await _visitorReportApi.confirmReport(id);
  }
}
