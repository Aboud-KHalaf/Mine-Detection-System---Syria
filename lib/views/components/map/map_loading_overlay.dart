import 'package:flutter/material.dart';

class MapLoadingOverlay extends StatelessWidget {
  final String text;

  const MapLoadingOverlay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 0,
      right: 0,
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
