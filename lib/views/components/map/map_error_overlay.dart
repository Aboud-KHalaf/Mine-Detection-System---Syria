import 'package:flutter/material.dart';

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
      bottom: 16,
      left: 16,
      right: 16,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),

          label: Text('Error: $message. Retry?'),
        ),
      ),
    );
  }
}
