import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/statistics_model.dart';

part 'general_api.g.dart';

@RestApi()
abstract class GeneralApi {
  factory GeneralApi(Dio dio, {String baseUrl}) = _GeneralApi;

  @GET('statistics/')
  Future<StatisticsModel> getStatistics();

  @GET('mine-types/')
  Future<dynamic> getMineTypes();
}
