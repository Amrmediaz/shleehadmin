// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitleOwner => 'Shleeh — Owner';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get login => 'Login';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get logout => 'Logout';

  @override
  String get languageToggleTooltip => 'Change language';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get bookings => 'Bookings';

  @override
  String get payments => 'Payments';

  @override
  String get customers => 'Customers';

  @override
  String get chalets => 'Chalets';

  @override
  String get hotelBuildings => 'Hotel Buildings';

  @override
  String get buildingOwners => 'Building Owners';

  @override
  String get hotelBookings => 'Hotel Bookings';

  @override
  String get revenue => 'Revenue';

  @override
  String get hotelRevenue => 'Hotel Revenue';

  @override
  String get paid => 'Paid';

  @override
  String get notPaid => 'Not Paid';

  @override
  String get noPaidBookings => 'No paid bookings yet.';

  @override
  String get noUnpaidBookings => 'No unpaid bookings right now.';

  @override
  String bookingNumber(int id) {
    return 'Booking #$id';
  }

  @override
  String daysCount(int count) {
    return '$count day(s)';
  }

  @override
  String get booking => 'Booking';

  @override
  String get bookedDays => 'Booked Days';

  @override
  String get customer => 'Customer';

  @override
  String get chalet => 'Chalet';

  @override
  String get cost => 'Cost';

  @override
  String get insurance => 'Insurance';

  @override
  String get days => 'Days';

  @override
  String get created => 'Created';

  @override
  String get note => 'Note';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get type => 'Type';

  @override
  String get location => 'Location';

  @override
  String get capacity => 'Capacity';

  @override
  String get fullDayRate => 'Full-day rate';

  @override
  String get fullDay => 'Full day';

  @override
  String get halfDay => 'Half day';

  @override
  String get enablePayment => 'Enable Payment';

  @override
  String enablePaymentForBooking(int id) {
    return 'Enable Payment — Booking #$id';
  }

  @override
  String get paymentType => 'Payment Type';

  @override
  String get paymentTypeOption1 => 'Type 1';

  @override
  String get paymentTypeOption2 => 'Type 2';

  @override
  String get confirm => 'Confirm';

  @override
  String get somethingWentWrong => 'Something went wrong.';

  @override
  String get noPayments => 'No payments yet.';

  @override
  String orderNumber(int id) {
    return 'Order #$id';
  }

  @override
  String get retry => 'Retry';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String pageOfPage(int current, int total) {
    return 'Page $current of $total';
  }
}
