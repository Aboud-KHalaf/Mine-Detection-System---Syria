import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/controllers/report_controller/report_cubit.dart';
import 'package:mds/controllers/report_controller/report_state.dart';
import 'package:mds/l10n/app_localizations.dart';

import 'add_report_error_mapper.dart';

class AddReportSubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const AddReportSubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        try {
          context.read<ReportCubit>();
        } catch (_) {
          return _AddReportSubmitButtonBody(
            isLoading: false,
            onPressed: onSubmit,
          );
        }

        return BlocConsumer<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is! ReportError) {
              return;
            }

            final colors = Theme.of(context).colorScheme;
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(mapReportErrorMessage(l10n, state)),
                backgroundColor: colors.errorContainer,
              ),
            );
          },
          builder: (context, state) {
            return _AddReportSubmitButtonBody(
              isLoading: state is ReportSubmitting,
              onPressed: onSubmit,
            );
          },
        );
      },
    );
  }
}

class _AddReportSubmitButtonBody extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _AddReportSubmitButtonBody({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: colors.primaryContainer),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.onPrimaryContainer,
                ),
              )
            : Text(
                AppLocalizations.of(context)!.transmitReport,
                style: textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.05,
                  fontWeight: FontWeight.bold,
                  color: colors.onPrimaryContainer,
                ),
              ),
      ),
    );
  }
}
