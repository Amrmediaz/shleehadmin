import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_exception.dart';
import '../data/payment_repository.dart';
import 'payment_list_state.dart';

class PaymentListCubit extends Cubit<PaymentListState> {
  PaymentListCubit({PaymentRepository? paymentRepository})
      : _paymentRepository = paymentRepository ?? PaymentRepository(),
        super(PaymentListState.loading()) {
    loadPage(1);
  }

  final PaymentRepository _paymentRepository;

  Future<void> loadPage(int page) async {
    emit(PaymentListState.loading());
    try {
      final result = await _paymentRepository.getPaymentList(page: page);
      emit(PaymentListState.loaded(result));
    } on ApiException catch (e) {
      emit(PaymentListState.error(e.message));
    } catch (_) {
      emit(PaymentListState.error('Could not reach the server. Check your connection.'));
    }
  }

  Future<void> refresh() => loadPage(state.page.currentPage == 0 ? 1 : state.page.currentPage);

  Future<void> nextPage() {
    if (!state.page.hasNextPage) return Future.value();
    return loadPage(state.page.currentPage + 1);
  }

  Future<void> previousPage() {
    if (!state.page.hasPreviousPage) return Future.value();
    return loadPage(state.page.currentPage - 1);
  }
}
