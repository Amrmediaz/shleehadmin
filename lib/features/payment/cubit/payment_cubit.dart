import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/payment_repository.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({PaymentRepository? paymentRepository})
      : _paymentRepository = paymentRepository ?? PaymentRepository(),
        super(const PaymentState.idle());

  final PaymentRepository _paymentRepository;

  Future<void> enableBookingPayment({
    required int bookingId,
    required int paymentType,
  }) async {
    emit(const PaymentState.submitting());
    try {
      await _paymentRepository.enableBookingPayment(
        bookingId: bookingId,
        paymentType: paymentType,
      );
      emit(const PaymentState.success());
    } on ApiException catch (e) {
      emit(e.isUnauthorized
          ? const PaymentState.unauthorized()
          : PaymentState.error(e.message));
    } catch (_) {
      emit(const PaymentState.error('Could not reach the server. Check your connection.'));
    }
  }

  void reset() => emit(const PaymentState.idle());
}
