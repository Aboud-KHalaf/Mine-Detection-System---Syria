import 'package:hive_ce/hive.dart';
import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/zone_model.dart';
import '../core/exceptions.dart';

class ZoneService {
  final ApiClient apiClient;

  ZoneService(this.apiClient);

  Future<List<ZoneModel>> getAllZones() async {
    try {
      final response = await apiClient.get(ApiConfig.zones);
      final List<dynamic> features = response.data['features'] ?? [];
      final zones = features.map((f) => ZoneModel.fromFeature(f)).toList();
      
      // Cache local mapping
      await _cacheZonesLocally(response.data);
      
      return zones;
    } catch (e) {
      if (e is OfflineException) {
        return _getCachedZones();
      }
      rethrow;
    }
  }

  Future<ZoneModel> createZone(Map<String, dynamic> zoneData) async {
    final response = await apiClient.post(ApiConfig.zones, data: zoneData);
    final newId = response.data['zone_id'];
    return getZoneDetails(newId);
  }

  Future<ZoneModel> getZoneDetails(int id) async {
    final response = await apiClient.get('${ApiConfig.zones}$id/');
    return ZoneModel.fromJson(response.data);
  }

  Future<void> editZone(int id, Map<String, dynamic> zoneData) async {
    await apiClient.put('${ApiConfig.zones}$id/', data: zoneData);
  }

  Future<void> deleteZone(int id) async {
    await apiClient.delete('${ApiConfig.zones}$id/');
  }

  Future<void> addReportToZone(int zoneId, String reportType, String description) async {
    await apiClient.post(
      ApiConfig.reportToZone(zoneId),
      data: {
        'report_type': reportType,
        'description': description,
      },
    );
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
