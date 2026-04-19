import 'package:hive_ce_flutter/hive_flutter.dart';

class SyncService {
  static Future<void> initLocalDatabase() async {
    await Hive.initFlutter();
    // Pre-open boxes commonly used
    await Hive.openBox('authBox');
    await Hive.openBox('zonesBox');
    await Hive.openBox('offlineReportsBox');
    await Hive.openBox('settingsBox');
  }
}
