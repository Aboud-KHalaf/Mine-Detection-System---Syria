class ApiConfig {
  static const String baseUrl = 'http://<your-domain>/api/';
  static const String login = 'login/';
  static const String zones = 'zones/';
  static const String visitorReports = 'visitor-reports/';
  static String reportToZone(int id) => 'zones/$id/reports/';
  static String confirmVisitorReport(int id) => 'visitor-reports/$id/confirm/';
  static const String statistics = 'statistics/';
  static const String mineTypes = 'mine-types/';
}
