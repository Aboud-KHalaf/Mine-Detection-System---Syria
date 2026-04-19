import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/l10n/app_localizations.dart';
import '../../../controllers/map_selection_cubit.dart';
import '../../../controllers/map_selection_state.dart';
import 'add_report_bottom_sheet.dart';

class AddReportButton extends StatelessWidget {
  const AddReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapSelectionCubit, MapSelectionState>(
      builder: (context, state) {
        final isLocationPinned = state is MapLocationSelected;
        final color = isLocationPinned
            ? Colors.redAccent.shade700
            : Colors.grey.shade700;

        return SizedBox(
          width: 72.0,
          height: 72.0,
          child: FloatingActionButton(
            heroTag: 'add_report_fab',
            onPressed: () {
              if (isLocationPinned) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const AddReportBottomSheet(),
                );
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.locationPinnedRequired,
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            backgroundColor: color,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
            ),
            child: const Icon(
              Icons.add_alert_rounded,
              size: 36.0,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
