import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'views/home/home_screen.dart';

void main() {
  runApp(const MdsApp());
}

class MdsApp extends StatelessWidget {
  const MdsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mine Detection System',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
