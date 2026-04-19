import 'package:flutter/material.dart';
import 'widgets/home_map_view.dart';
import 'widgets/current_location_button.dart';
import 'widgets/add_report_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Full-Screen Map takes the entire background
          const HomeMapView(),
          
          // 2. Floating Action Buttons (Bottom Area)
          Positioned(
            right: 16.0,
            bottom: 32.0, // Thumb-friendly positioning
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CurrentLocationButton(),
                SizedBox(height: 16.0),
                AddReportButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
