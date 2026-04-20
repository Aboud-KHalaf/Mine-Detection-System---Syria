import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'zone_api.g.dart';

@RestApi()
abstract class ZoneApi {
  factory ZoneApi(Dio dio, {String baseUrl}) = _ZoneApi;

  @GET('zones/')
  Future<dynamic> getZones();

  @POST('zones/')
  Future<dynamic> createZone(@Body() Map<String, dynamic> body);

  @GET('zones/{id}/')
  Future<dynamic> getZoneDetails(@Path('id') int id);

  @PUT('zones/{id}/')
  Future<void> editZone(@Path('id') int id, @Body() Map<String, dynamic> body);

  @DELETE('zones/{id}/')
  Future<void> deleteZone(@Path('id') int id);

  @POST('zones/{id}/reports/')
  Future<dynamic> submitReport(@Path('id') int id, @Body() Map<String, dynamic> body);
}
