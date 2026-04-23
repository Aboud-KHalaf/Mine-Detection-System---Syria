import 'package:mds/controllers/report_controller/report_state.dart';
import 'package:mds/l10n/app_localizations.dart';

String mapReportErrorMessage(AppLocalizations l10n, ReportError error) {
  return switch (error.failure) {
    ReportFailure.api => error.serverMessage ?? l10n.errorGenericServer,
    ReportFailure.offlineQueued => l10n.reportErrorOfflineQueued,
    ReportFailure.unknown => l10n.errorUnknown,
  };
}
