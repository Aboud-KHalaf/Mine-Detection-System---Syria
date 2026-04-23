import 'dart:io';

import 'package:dio/dio.dart';

import '../core/api/api_client.dart';
import '../core/errors/exceptions.dart';
import '../models/visitor_report_model.dart';
import 'api/visitor_report_api.dart';

class VisitorReportService {
  final ApiClient apiClient;
  final VisitorReportApi _visitorReportApi;

  VisitorReportService(this.apiClient)
    : _visitorReportApi = VisitorReportApi(apiClient.dio);

  Future<void> submitVisitorReport({
    required String fullName,
    required String phone,
    required List<double> coordinates,
    String? notes,
    String? imagePath,
  }) async {
    if (coordinates.length != 2) {
      throw ArgumentError('Coordinates must contain [latitude, longitude]');
    }

    final trimmedName = fullName.trim();
    final trimmedPhone = phone.trim();
    final trimmedNotes = notes?.trim();

    final formData = FormData();
    formData.fields
      ..add(MapEntry('full_name', trimmedName))
      ..add(MapEntry('phone', trimmedPhone))
      // API expects this field repeated twice in multipart/form-data.
      ..add(MapEntry('coordinates', coordinates[0].toString()))
      ..add(MapEntry('coordinates', coordinates[1].toString()));

    if (trimmedNotes != null && trimmedNotes.isNotEmpty) {
      formData.fields.add(MapEntry('notes', trimmedNotes));
    }

    if (imagePath != null && imagePath.trim().isNotEmpty) {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              imagePath,
              filename: imagePath.split(Platform.pathSeparator).last,
            ),
          ),
        );
      }
    }

    try {
      await apiClient.dio.post(
        'visitor-reports/',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Exception _mapDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError ||
        (e.type == DioExceptionType.unknown &&
            e.message?.contains('SocketException') == true)) {
      return OfflineException('No internet connection.');
    }

    final statusCode = e.response?.statusCode;
    return ApiException(_extractServerMessage(e.response?.data), statusCode);
  }

  String _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? data['detail'];
      if (message is String && message.isNotEmpty) {
        return message;
      }

      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty && errors.first is String) {
        return errors.first as String;
      }
    }

    return 'An unknown API error occurred.';
  }

  Future<List<VisitorReportModel>> getVisitorReports() async {
    final response = await _visitorReportApi.getVisitorReports();
    final List<dynamic> reports = response['reports'] ?? [];
    return reports
        .map((e) => VisitorReportModel.fromJson(e as Map<String, dynamic>))
        .toList();
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
