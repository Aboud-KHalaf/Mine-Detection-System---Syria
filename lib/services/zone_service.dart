import 'package:hive_ce/hive.dart';
import '../core/api_client.dart';
import '../models/zone_model.dart';
import '../core/exceptions.dart';
import 'api/zone_api.dart';

class ZoneService {
  final ApiClient apiClient;
  final ZoneApi _zoneApi;

  ZoneService(this.apiClient) : _zoneApi = ZoneApi(apiClient.dio);

  Future<List<ZoneModel>> getAllZones() async {
    try {
      final response = await _zoneApi.getZones();
      final List<dynamic> features = response['features'] ?? [];
      final zones = features.map((f) => ZoneModel.fromFeature(f)).toList();

      // Cache local mapping
      await _cacheZonesLocally(response);

      return zones;
    } catch (e) {
      if (e is OfflineException) {
        return _getCachedZones();
      }
      rethrow;
    }
  }

  Future<ZoneModel> createZone(Map<String, dynamic> zoneData) async {
    final response = await _zoneApi.createZone(zoneData);
    final newId = response['zone_id'];
    return getZoneDetails(newId);
  }

  Future<ZoneModel> getZoneDetails(int id) async {
    final response = await _zoneApi.getZoneDetails(id);
    return ZoneModel.fromJson(response);
  }

  Future<void> editZone(int id, Map<String, dynamic> zoneData) async {
    await _zoneApi.editZone(id, zoneData);
  }

  Future<void> deleteZone(int id) async {
    await _zoneApi.deleteZone(id);
  }

  Future<void> addReportToZone(
    int zoneId,
    String reportType,
    String description,
  ) async {
    await _zoneApi.submitReport(zoneId, {
      'report_type': reportType,
      'description': description,
    });
  }

  Future<void> _cacheZonesLocally(Map<String, dynamic> data) async {
    final box = await Hive.openBox('zonesBox');
    await box.put('allZones', data);
  }

  Future<List<ZoneModel>> _getCachedZones() async {
    final box = await Hive.openBox('zonesBox');
    final data = box.get('allZones');
    if (data != null && data is Map<String, dynamic>) {
      final List<dynamic> features = data['features'] ?? [];
      return features.map((f) => ZoneModel.fromFeature(f)).toList();
    }
    return [];
  }
}
