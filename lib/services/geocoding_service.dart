import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class GeocodingService {
  final Dio _dio;
  static const String _baseUrl = 'https://nominatim.openstreetmap.org/search';

  GeocodingService(this._dio);

  Future<LatLng?> searchLocation(String query) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': 1,
        },
        options: Options(
          headers: {
            'User-Agent': 'Mine Detection System Syria',
          },
        ),
      );

      if (response.data is List && (response.data as List).isNotEmpty) {
        final firstMatch = (response.data as List).first;
        final lat = double.parse(firstMatch['lat']);
        final lon = double.parse(firstMatch['lon']);
        return LatLng(lat, lon);
      }
      return null;
    } catch (e) {
      print('Geocoding Error: $e');
      return null;
    }
  }
}
