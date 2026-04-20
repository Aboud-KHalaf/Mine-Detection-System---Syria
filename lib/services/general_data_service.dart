import '../core/api_client.dart';
import '../models/statistics_model.dart';
import 'api/general_api.dart';

class GeneralDataService {
  final ApiClient apiClient;
  final GeneralApi _generalApi;

  GeneralDataService(this.apiClient) : _generalApi = GeneralApi(apiClient.dio);

  Future<StatisticsModel> getStatistics() async {
    return await _generalApi.getStatistics();
  }

  Future<List<MineTypeModel>> getMineTypes() async {
    final response = await _generalApi.getMineTypes();
    final List<dynamic> list = response['mine_types'] ?? [];
    return list.map((e) => MineTypeModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
