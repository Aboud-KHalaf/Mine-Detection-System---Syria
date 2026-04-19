import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/statistics_model.dart';

class GeneralDataService {
  final ApiClient apiClient;

  GeneralDataService(this.apiClient);

  Future<StatisticsModel> getStatistics() async {
    final response = await apiClient.get(ApiConfig.statistics);
    return StatisticsModel.fromJson(response.data);
  }

  Future<List<MineTypeModel>> getMineTypes() async {
    final response = await apiClient.get(ApiConfig.mineTypes);
    final List<dynamic> list = response.data['mine_types'] ?? [];
    return list.map((e) => MineTypeModel.fromJson(e)).toList();
  }
}
