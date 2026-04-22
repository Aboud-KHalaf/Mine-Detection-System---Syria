// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mine detection system';

  @override
  String get fieldMap => 'FIELD MAP';

  @override
  String get statistics => 'STATISTICS';

  @override
  String get operationalSettings => 'OPERATIONAL SETTINGS';

  @override
  String get searchHint => 'Search coordinates or zones...';

  @override
  String get locationPinnedRequired =>
      'Long-press on the map to pin the hazard location first.';

  @override
  String get submitHazardReport => 'SUBMIT HAZARD REPORT';

  @override
  String linkedLocation(String lat, String lng) {
    return 'LINKED LOCATION: $lat, $lng';
  }

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number (e.g. +963)';

  @override
  String get notes => 'Additional Visual Details (Optional)';

  @override
  String get attachImage => 'ATTACH IMAGE';

  @override
  String get transmitReport => 'TRANSMIT REPORT';

  @override
  String get reportSuccess => 'Report submitted or queued for offline sync!';

  @override
  String get requiredField => 'Required field';

  @override
  String get reportCubitError => 'Report Cubit not yet provided in main.dart';

  @override
  String get language => 'Language';

  @override
  String get switchToArabic => 'Switch to Arabic';

  @override
  String get switchToEnglish => 'Switch to English';

  @override
  String get mapType => 'Map Type';

  @override
  String get defaultMap => 'Default';

  @override
  String get satellite => 'Satellite';

  @override
  String get terrain => 'Terrain';

  @override
  String pinnedHazardAt(String lat, String lng) {
    return 'Pinned hazard at: $lat, $lng';
  }

  @override
  String get fetchingLocation => 'Fetching your location...';

  @override
  String get loadingSafeZones => 'Loading safe zones...';

  @override
  String get errorOffline =>
      'You appear to be offline. Please check your connection.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get errorGenericServer => 'Server error. Please try again.';

  @override
  String get mapErrorLocationServicesDisabled =>
      'Unable to get your location. Please enable location services.';

  @override
  String get mapErrorLocationNotFound =>
      'Location not found. Try different keywords.';

  @override
  String get mapErrorUnknown => 'Something went wrong. Please try again.';

  @override
  String get reportErrorOfflineQueued =>
      'Offline. Your report has been queued and will sync later.';

  @override
  String errorRetry(String message) {
    return 'Error: $message. Retry?';
  }

  @override
  String get mapTheme => 'Map Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String appVersion(String version) {
    return 'App Version: $version';
  }
}
