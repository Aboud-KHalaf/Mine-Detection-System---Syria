// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تاكتيكال سنتينل';

  @override
  String get fieldMap => 'خريطة الميدان';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get operationalSettings => 'الإعدادات التشغيلية';

  @override
  String get searchHint => 'البحث عن إحداثيات أو مناطق...';

  @override
  String get locationPinnedRequired =>
      'اضغط مطولاً على الخريطة لتحديد موقع الخطر أولاً.';

  @override
  String get submitHazardReport => 'إرسال تقرير عن خطر';

  @override
  String linkedLocation(String lat, String lng) {
    return 'الموقع المرتبط: $lat, $lng';
  }

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get phoneNumber => 'رقم الهاتف (مثلاً +963)';

  @override
  String get notes => 'تفاصيل بصرية إضافية (اختياري)';

  @override
  String get attachImage => 'إرفاق صورة';

  @override
  String get transmitReport => 'إرسال التقرير';

  @override
  String get reportSuccess =>
      'تم إرسال التقرير أو وضعه في قائمة الانتظار للمزامنة!';

  @override
  String get requiredField => 'حقل مطلوب';

  @override
  String get reportCubitError => 'لم يتم توفير Report Cubit في main.dart بعد';

  @override
  String get language => 'اللغة';

  @override
  String get switchToArabic => 'التبديل إلى العربية';

  @override
  String get switchToEnglish => 'التبديل إلى الإنجليزية';

  @override
  String get mapType => 'نوع الخريطة';

  @override
  String get defaultMap => 'الافتراضي';

  @override
  String get satellite => 'قمر صناعي';

  @override
  String get terrain => 'تضاريس';

  @override
  String pinnedHazardAt(String lat, String lng) {
    return 'تم تحديد الخطر في: $lat, $lng';
  }

  @override
  String get fetchingLocation => 'جاري إحضار موقعك...';

  @override
  String get loadingSafeZones => 'جاري تحميل المناطق الآمنة...';

  @override
  String get errorOffline =>
      'يبدو أنك غير متصل بالإنترنت. يرجى التحقق من الاتصال.';

  @override
  String get errorUnknown => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get errorGenericServer => 'خطأ في الخادم. يرجى المحاولة مرة أخرى.';

  @override
  String get mapErrorLocationServicesDisabled =>
      'تعذر الحصول على موقعك. يرجى تفعيل خدمات الموقع.';

  @override
  String get mapErrorLocationNotFound =>
      'لم يتم العثور على الموقع. يرجى المحاولة بكلمات أخرى.';

  @override
  String get mapErrorUnknown => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get reportErrorOfflineQueued =>
      'أنت غير متصل بالإنترنت. تم وضع التقرير في قائمة الانتظار وسيتم مزامنته لاحقاً.';

  @override
  String errorRetry(String message) {
    return 'خطأ: $message. إعادة المحاولة؟';
  }
}
