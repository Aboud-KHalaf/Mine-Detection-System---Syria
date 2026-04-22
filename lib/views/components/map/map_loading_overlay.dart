import 'package:flutter/material.dart';

class MapLoadingOverlay extends StatefulWidget {
  final String text;

  const MapLoadingOverlay({super.key, required this.text});

  @override
  State<MapLoadingOverlay> createState() => _MapLoadingOverlayState();
}

class _MapLoadingOverlayState extends State<MapLoadingOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, -0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
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
                    Text(widget.text),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
