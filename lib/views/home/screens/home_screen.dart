import 'package:flutter/material.dart';
import 'widgets/home_map_view.dart';
import 'widgets/current_location_button.dart';
import 'widgets/add_report_button.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _searchBarSlide;
  late final Animation<double> _searchBarFade;
  late final Animation<Offset> _fabsSlide;
  late final Animation<double> _fabsFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Search bar: slides in from top
    _searchBarSlide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));

    _searchBarFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // FABs: slide in from right with slight delay
    _fabsSlide = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _fabsFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          // 1. Full-Screen Map takes the entire background
          const HomeMapView(),

          // 2. Search Bar overlay (acts as top HUD) — slides in from top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _searchBarFade,
              child: SlideTransition(
                position: _searchBarSlide,
                child: const HomeSearchBar(),
              ),
            ),
          ),

          // 3. Floating Action Buttons (Bottom Area) — slide in from right
          Positioned(
            right: 16.0,
            bottom: 32.0,
            child: FadeTransition(
              opacity: _fabsFade,
              child: SlideTransition(
                position: _fabsSlide,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CurrentLocationButton(),
                    SizedBox(height: 16.0),
                    AddReportButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
