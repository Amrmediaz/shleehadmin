import 'package:equatable/equatable.dart';

import '../data/booking.dart';

enum BookingDetailsStatus { loading, loaded, error }

class BookingDetailsState extends Equatable {
  final BookingDetailsStatus status;
  final Booking? booking;
  final String? errorMessage;

  const BookingDetailsState._({required this.status, this.booking, this.errorMessage});

  const BookingDetailsState.loading() : this._(status: BookingDetailsStatus.loading);

  const BookingDetailsState.loaded(Booking booking)
      : this._(status: BookingDetailsStatus.loaded, booking: booking);

  const BookingDetailsState.error(String message)
      : this._(status: BookingDetailsStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [status, booking?.id, errorMessage];
}
