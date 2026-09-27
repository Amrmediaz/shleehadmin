import 'package:equatable/equatable.dart';

import '../../../core/models/paginated_result.dart';
import '../data/booking.dart';

enum BookingListStatus { loading, loaded, error }

class BookingListState extends Equatable {
  final BookingListStatus status;
  final PaginatedResult<Booking> page;
  final String? errorMessage;

  const BookingListState._({required this.status, required this.page, this.errorMessage});

  BookingListState.loading() : this._(status: BookingListStatus.loading, page: PaginatedResult.empty<Booking>());

  const BookingListState.loaded(PaginatedResult<Booking> page)
      : this._(status: BookingListStatus.loaded, page: page);

  BookingListState.error(String message)
      : this._(status: BookingListStatus.error, page: PaginatedResult.empty<Booking>(), errorMessage: message);

  @override
  List<Object?> get props => [status, page.currentPage, page.results.length, errorMessage];
}
