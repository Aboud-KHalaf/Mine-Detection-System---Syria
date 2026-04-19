import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/general_data_service.dart';
import 'statistics_state.dart';
import '../core/exceptions.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final GeneralDataService dataService;

  StatisticsCubit(this.dataService) : super(StatisticsInitial());

  Future<void> fetchDashboardData() async {
    emit(StatisticsLoading());
    try {
      final stats = await dataService.getStatistics();
      final mineTypes = await dataService.getMineTypes();
      emit(StatisticsLoaded(stats, mineTypes));
    } on ApiException catch (e) {
      emit(StatisticsError(e.message));
    } catch (e) {
      emit(const StatisticsError('Error loading dashboard data.'));
    }
  }
}
