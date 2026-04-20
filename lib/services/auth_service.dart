import 'package:hive_ce/hive.dart';
import '../core/api_client.dart';
import '../models/user_token_model.dart';
import 'api/auth_api.dart';

class AuthService {
  final ApiClient apiClient;
  final AuthApi _authApi;

  AuthService(this.apiClient) : _authApi = AuthApi(apiClient.dio);

  Future<UserTokenModel> login(String username, String password) async {
    final tokenModel = await _authApi.login({
      'username': username,
      'password': password,
    });
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
