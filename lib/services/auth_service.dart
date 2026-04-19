import 'package:hive_ce/hive.dart';
import '../core/api_client.dart';
import '../core/api_config.dart';
import '../models/user_token_model.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<UserTokenModel> login(String username, String password) async {
    final response = await apiClient.post(
      ApiConfig.login,
      data: {
        'username': username,
        'password': password,
      },
    );
    final tokenModel = UserTokenModel.fromJson(response.data);
    await _saveTokenLocally(tokenModel.token);
    apiClient.setToken(tokenModel.token);
    return tokenModel;
  }

  Future<void> _saveTokenLocally(String token) async {
    final box = await Hive.openBox('authBox');
    await box.put('token', token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox('authBox');
    final token = box.get('token') as String?;
    if (token != null) {
      apiClient.setToken(token);
    }
    return token;
  }

  Future<void> logout() async {
    final box = await Hive.openBox('authBox');
    await box.delete('token');
    apiClient.removeToken();
  }
}
