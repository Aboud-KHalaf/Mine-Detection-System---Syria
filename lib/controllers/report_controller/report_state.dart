import 'package:equatable/equatable.dart';

enum ReportFailure {
  api,
  offlineQueued,
  unknown,
}

abstract class ReportState extends Equatable {
  const ReportState();
  
  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportSubmitting extends ReportState {}

class ReportSuccess extends ReportState {}

class ReportError extends ReportState {
  final ReportFailure failure;
  final String? serverMessage;
  final String? debugMessage;

  const ReportError(
    this.failure, {
    this.serverMessage,
    this.debugMessage,
  });

  @override
  List<Object?> get props => [failure, serverMessage, debugMessage];
}
