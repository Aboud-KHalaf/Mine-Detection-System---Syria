import 'package:equatable/equatable.dart';
import '../models/statistics_model.dart';


abstract class StatisticsState extends Equatable {
  const StatisticsState();
  
  @override
  List<Object?> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final StatisticsModel stats;
  final List<MineTypeModel> mineTypes;

  const StatisticsLoaded(this.stats, this.mineTypes);

  @override
  List<Object?> get props => [stats, mineTypes];
}

class StatisticsError extends StatisticsState {
  final String message;
  const StatisticsError(this.message);

  @override
  List<Object?> get props => [message];
}
