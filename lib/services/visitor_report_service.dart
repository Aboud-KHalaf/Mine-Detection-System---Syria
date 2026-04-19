import 'package:dio/dio.dart';
import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/visitor_report_model.dart';

class VisitorReportService {
  final ApiClient apiClient;

  VisitorReportService(this.apiClient);

  Future<void> submitVisitorReport({
    required String fullName,
    required String phone,
    required List<double> coordinates,
    String? notes,
    String? imagePath,
  }) async {
    final formData = FormData.fromMap({
      'full_name': fullName,
      'phone': phone,
      'coordinates': coordinates[0],
    });
    // Add second coordinate separately to form an array if backend expects it this way
    formData.fields.add(MapEntry('coordinates', coordinates[1].toString()));

    if (notes != null) {
      formData.fields.add(MapEntry('notes', notes));
    }

    if (imagePath != null) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(imagePath),
      ));
    }

    await apiClient.post(ApiConfig.visitorReports, data: formData);
  }

  Future<List<VisitorReportModel>> getVisitorReports() async {
    final response = await apiClient.get(ApiConfig.visitorReports);
    final List<dynamic> reports = response.data['reports'] ?? [];
    return reports.map((e) => VisitorReportModel.fromJson(e)).toList();
  }

  Future<VisitorReportModel> getVisitorReportDetails(int id) async {
    final response = await apiClient.get('${ApiConfig.visitorReports}$id/');
    return VisitorReportModel.fromJson(response.data);
  }

  Future<void> deleteVisitorReport(int id) async {
    await apiClient.delete('${ApiConfig.visitorReports}$id/');
  }

  Future<void> confirmVisitorReport(int id) async {
    await apiClient.post(ApiConfig.confirmVisitorReport(id));
  }
}
