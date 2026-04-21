import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/visitor_report_service.dart';
import 'report_state.dart';
import '../core/exceptions.dart';

class ReportCubit extends Cubit<ReportState> {
  final VisitorReportService reportService;

  ReportCubit(this.reportService) : super(ReportInitial());

  Future<void> submitVisitorReport({
    required String fullName,
    required String phone,
    required List<double> coordinates,
    String? notes,
    String? imagePath,
  }) async {
    emit(ReportSubmitting());
    try {
      await reportService.submitVisitorReport(
        fullName: fullName,
        phone: phone,
        coordinates: coordinates,
        notes: notes,
        imagePath: imagePath,
      );
      emit(ReportSuccess());
    } on ApiException catch (e) {
      emit(ReportError(ReportFailure.api, serverMessage: e.message));
    } on OfflineException catch (_) {
      // In a robust implementation, this would be queued in Hive and synced later
      // For now, we simulate an offline handling state.
      emit(const ReportError(ReportFailure.offlineQueued));
    } catch (e) {
      emit(ReportError(ReportFailure.unknown, debugMessage: e.toString()));
    }
  }
}
