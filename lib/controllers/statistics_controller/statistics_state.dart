import 'package:equatable/equatable.dart';
import '../../models/statistics_model.dart';

enum StatisticsFailure { api, unknown }

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
  final StatisticsFailure failure;
  final String? serverMessage;
  final String? debugMessage;

  const StatisticsError(this.failure, {this.serverMessage, this.debugMessage});

  @override
  List<Object?> get props => [failure, serverMessage, debugMessage];
}
