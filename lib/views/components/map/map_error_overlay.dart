import 'package:flutter/material.dart';
import 'package:mds/l10n/app_localizations.dart';

class MapErrorOverlay extends StatefulWidget {
  final String message;
  final VoidCallback onRetry;

  const MapErrorOverlay({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  State<MapErrorOverlay> createState() => _MapErrorOverlayState();
}

class _MapErrorOverlayState extends State<MapErrorOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, -0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
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
    return Positioned(
      top: 110,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Center(
            child: ElevatedButton.icon(
              onPressed: widget.onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(
                AppLocalizations.of(context)!.errorRetry(widget.message),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
