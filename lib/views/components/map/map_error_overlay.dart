import 'package:flutter/material.dart';
import 'package:mds/l10n/app_localizations.dart';

class MapErrorOverlay extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const MapErrorOverlay({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      left: 16,
      right: 16,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),

          label: Text(AppLocalizations.of(context)!.errorRetry(message)),
        ),
      ),
    );
  }
}
