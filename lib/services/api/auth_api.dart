import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/user_token_model.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('login/')
  Future<UserTokenModel> login(@Body() Map<String, dynamic> body);
}
