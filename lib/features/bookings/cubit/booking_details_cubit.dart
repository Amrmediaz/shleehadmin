import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/bookings_repository.dart';
import 'booking_details_state.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  BookingDetailsCubit({BookingsRepository? bookingsRepository})
      : _bookingsRepository = bookingsRepository ?? BookingsRepository(),
        super(const BookingDetailsState.loading());

  final BookingsRepository _bookingsRepository;

  Future<void> load(int bookingId) async {
    emit(const BookingDetailsState.loading());
    try {
      final booking = await _bookingsRepository.getBookingDetails(bookingId);
      emit(BookingDetailsState.loaded(booking));
    } on ApiException catch (e) {
      emit(BookingDetailsState.error(e.message));
    } catch (_) {
      emit(const BookingDetailsState.error('Could not reach the server. Check your connection.'));
    }
  }
}
