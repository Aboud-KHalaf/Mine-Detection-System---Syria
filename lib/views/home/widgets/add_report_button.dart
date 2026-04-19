import 'package:flutter/material.dart';

class AddReportButton extends StatelessWidget {
  const AddReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.0, // Larger size to stand out
      height: 72.0,
      child: FloatingActionButton(
        heroTag: 'add_report_fab',
        onPressed: () {
          // TODO: Navigate to reporting flow
        },
        backgroundColor: Colors.redAccent.shade700,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0), // Fully circular
        ),
        child: const Icon(
          Icons.add_alert_rounded,
          size: 36.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
