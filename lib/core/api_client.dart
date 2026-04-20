import 'package:dio/dio.dart';
import 'api_config.dart';
import 'exceptions.dart';

class ApiClient {
  final Dio _dio;

  Dio get dio => _dio;

  ApiClient({Dio? dio}) : _dio = dio ?? Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    )
  );

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Token $token';
  }

  void removeToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      return OfflineException('Connection timed out. Please check your internet connection.');
    } else if (e.type == DioExceptionType.unknown && e.message?.contains('SocketException') == true) {
      return OfflineException('No internet connection.');
    }
    
    String errorMessage = 'An unknown API error occurred.';
    if (e.response?.data != null && e.response?.data is Map) {
      final data = e.response!.data as Map;
      errorMessage = data['message'] ?? errorMessage;
    }
    
    return ApiException(errorMessage, e.response?.statusCode);
  }
}
