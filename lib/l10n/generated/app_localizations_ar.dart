// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitleOwner => 'شاليه.كوم — المالك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get languageToggleTooltip => 'تغيير اللغة';

  @override
  String get dashboard => 'الرئيسية';

  @override
  String get bookings => 'الحجوزات';

  @override
  String get payments => 'المدفوعات';

  @override
  String get customers => 'العملاء';

  @override
  String get chalets => 'الشاليهات';

  @override
  String get hotelBuildings => 'المباني الفندقية';

  @override
  String get buildingOwners => 'ملاك المباني';

  @override
  String get hotelBookings => 'حجوزات الفنادق';

  @override
  String get revenue => 'الإيرادات';

  @override
  String get hotelRevenue => 'إيرادات الفنادق';

  @override
  String get paid => 'مدفوع';

  @override
  String get notPaid => 'غير مدفوع';

  @override
  String get noPaidBookings => 'لا توجد حجوزات مدفوعة بعد.';

  @override
  String get noUnpaidBookings => 'لا توجد حجوزات غير مدفوعة حالياً.';

  @override
  String bookingNumber(int id) {
    return 'الحجز رقم $id';
  }

  @override
  String daysCount(int count) {
    return '$count يوم';
  }

  @override
  String get booking => 'الحجز';

  @override
  String get bookedDays => 'أيام الحجز';

  @override
  String get customer => 'العميل';

  @override
  String get chalet => 'الشاليه';

  @override
  String get cost => 'التكلفة';

  @override
  String get insurance => 'التأمين';

  @override
  String get days => 'الأيام';

  @override
  String get created => 'تاريخ الإنشاء';

  @override
  String get note => 'ملاحظة';

  @override
  String get name => 'الاسم';

  @override
  String get phone => 'الهاتف';

  @override
  String get type => 'النوع';

  @override
  String get location => 'الموقع';

  @override
  String get capacity => 'السعة';

  @override
  String get fullDayRate => 'سعر اليوم الكامل';

  @override
  String get fullDay => 'يوم كامل';

  @override
  String get halfDay => 'نصف يوم';

  @override
  String get enablePayment => 'تفعيل الدفع';

  @override
  String enablePaymentForBooking(int id) {
    return 'تفعيل الدفع — الحجز رقم $id';
  }

  @override
  String get paymentType => 'نوع الدفع';

  @override
  String get paymentTypeOption1 => 'النوع 1';

  @override
  String get paymentTypeOption2 => 'النوع 2';

  @override
  String get confirm => 'تأكيد';

  @override
  String get somethingWentWrong => 'حدث خطأ ما.';

  @override
  String get noPayments => 'لا توجد مدفوعات بعد.';

  @override
  String orderNumber(int id) {
    return 'الطلب رقم $id';
  }

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get previous => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String pageOfPage(int current, int total) {
    return 'صفحة $current من $total';
  }
}
