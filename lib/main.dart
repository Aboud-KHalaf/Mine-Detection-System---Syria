import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mds/l10n/app_localizations.dart';

import 'core/api/api_client.dart';
import 'core/theme/app_theme.dart';
import 'services/auth_service.dart';
import 'services/general_data_service.dart';
import 'services/sync_service.dart';
import 'services/visitor_report_service.dart';
import 'services/zone_service.dart';
import 'services/geocoding_service.dart';
import 'controllers/auth_controller/auth_cubit.dart';
import 'controllers/report_controller/report_cubit.dart';
import 'controllers/map_zone_controller/map_zone_cubit.dart';
import 'controllers/map_selection_controller/map_selection_cubit.dart';
import 'controllers/statistics_controller/statistics_cubit.dart';
import 'controllers/local_controller/locale_cubit.dart';
import 'controllers/local_controller/locale_state.dart';
import 'views/home/screens/home_screen.dart';

import 'services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and Local Database boxes
  await SyncService.initLocalDatabase();

  // Setup Core API Client
  final apiClient = ApiClient();

  // Setup Services
  final authService = AuthService(apiClient);
  final zoneService = ZoneService(apiClient);
  final reportService = VisitorReportService(apiClient);
  final generalDataService = GeneralDataService(apiClient);
  final locationService = LocationService();
  final geocodingService = GeocodingService(Dio());

  runApp(
    MdsApp(
      authService: authService,
      zoneService: zoneService,
      reportService: reportService,
      generalDataService: generalDataService,
      locationService: locationService,
      geocodingService: geocodingService,
    ),
  );
}

class MdsApp extends StatelessWidget {
  final AuthService authService;
  final ZoneService zoneService;
  final VisitorReportService reportService;
  final GeneralDataService generalDataService;
  final LocationService locationService;
  final GeocodingService geocodingService;

  const MdsApp({
    super.key,
    required this.authService,
    required this.zoneService,
    required this.reportService,
    required this.generalDataService,
    required this.locationService,
    required this.geocodingService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => AuthCubit(authService)),
        BlocProvider(create: (_) => MapZoneCubit(zoneService)),
        BlocProvider(create: (_) => ReportCubit(reportService)),
        BlocProvider(
          create: (_) => MapSelectionCubit(locationService, geocodingService),
        ),
        BlocProvider(create: (_) => StatisticsCubit(generalDataService)),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Tactical Sentinel',
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: ThemeMode.dark,
            darkTheme: AppTheme.dark(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
