import '../../../core/models/paginated_result.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import 'booking.dart';

class BookingsRepository {
  BookingsRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  /// Both PaidBookingList and NotPaidBookingList are POST endpoints with the
  /// request body `{"page": int, "pageSize": int}` (confirmed via swagger).
  Future<PaginatedResult<Booking>> getPaidBookings({int page = 1, int pageSize = 10}) async {
    final message = await _apiClient.postEnvelope(
      ApiEndpoints.paidBookingList,
      body: {'page': page, 'pageSize': pageSize},
    );
    return PaginatedResult.fromJson(message, Booking.fromJson);
  }

  Future<PaginatedResult<Booking>> getNotPaidBookings({int page = 1, int pageSize = 10}) async {
    final message = await _apiClient.postEnvelope(
      ApiEndpoints.notPaidBookingList,
      body: {'page': page, 'pageSize': pageSize},
    );
    return PaginatedResult.fromJson(message, Booking.fromJson);
  }

  /// Single-booking lookup by ID — kept as GET with a query param, matching
  /// the `?ID=1` shape you shared.
  Future<Booking> getBookingDetails(int id) async {
    final message = await _apiClient.getEnvelope(
      ApiEndpoints.bookingDetails,
      queryParams: {'ID': id},
    );
    return Booking.fromJson(message);
  }
}
