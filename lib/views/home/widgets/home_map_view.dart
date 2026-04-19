import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(34.8021, 38.9968), // Roughly Syria coordinates
        initialZoom: 6.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.mds', 
        ),
        // Placeholder for the transparent red danger zone polygon
        PolygonLayer(
          polygons: [
            Polygon(
              points: const [
                LatLng(34.0, 38.0),
                LatLng(34.0, 39.0),
                LatLng(35.0, 39.0),
                LatLng(35.0, 38.0),
              ],
              color: Colors.redAccent.withAlpha(80), 
              borderColor: Colors.red,
              borderStrokeWidth: 2,
            ),
          ],
        ),
      ],
    );
  }
}
