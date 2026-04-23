import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/api/api_client.dart';
import '../models/user_token_model.dart';
import 'api/auth_api.dart';

class AuthService {
  final ApiClient apiClient;
  final AuthApi _authApi;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

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
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: 'token');
    if (token != null) {
      apiClient.setToken(token);
    }
    return token;
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'token');
    apiClient.removeToken();
  }
}
