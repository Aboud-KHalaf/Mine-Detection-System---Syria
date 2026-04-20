import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/visitor_report_model.dart';
import 'dart:io';

part 'visitor_report_api.g.dart';

@RestApi()
abstract class VisitorReportApi {
  factory VisitorReportApi(Dio dio, {String baseUrl}) = _VisitorReportApi;

  @GET('visitor-reports/')
  Future<dynamic> getVisitorReports();

  @POST('visitor-reports/')
  @MultiPart()
  Future<VisitorReportModel> submitVisitorReport(
    @Part(name: "full_name") String fullName,
    @Part(name: "phone") String phone,
    @Part(name: "coordinates") String coordinates,
    @Part(name: "notes") String? notes,
    @Part(name: "image") File? image,
  );

  @GET('visitor-reports/{id}/')
  Future<VisitorReportModel> getVisitorReportDetails(@Path('id') int id);

  @DELETE('visitor-reports/{id}/')
  Future<void> deleteVisitorReport(@Path('id') int id);

  @POST('visitor-reports/{id}/confirm/')
  Future<VisitorReportModel> confirmReport(@Path('id') int id);
}
