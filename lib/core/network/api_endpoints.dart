/// Central place for the Shleeh (شاليه.كوم) backend base URL and endpoint
/// paths. Add new endpoints here as more API calls get wired up.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://shleeh.com/api';

  // Auth
  static const String ownerLogin = '/AppOwner/AppOwnerLogin';

  // Dashboard
  static const String homePage = '/AppOwner/HomePage';

  // Payments
  static const String outPayment = '/AppOwner/OutPayment';
  static const String paymentList = '/AppOwner/PaymentList';

  // Bookings
  static const String paidBookingList = '/AppOwner/PaidBookingList';
  static const String notPaidBookingList = '/AppOwner/NotPaidBookingList';
  // Note: "Detiles" (not "Details") matches the live API's spelling.
  static const String bookingDetails = '/AppOwner/BookingDetiles';
}
