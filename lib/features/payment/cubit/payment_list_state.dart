import 'package:equatable/equatable.dart';

import '../../../core/models/paginated_result.dart';
import '../data/payment_list_item.dart';

enum PaymentListStatus { loading, loaded, error }

class PaymentListState extends Equatable {
  final PaymentListStatus status;
  final PaginatedResult<PaymentListItem> page;
  final String? errorMessage;

  const PaymentListState._({required this.status, required this.page, this.errorMessage});

  PaymentListState.loading()
      : this._(status: PaymentListStatus.loading, page: PaginatedResult.empty<PaymentListItem>());

  const PaymentListState.loaded(PaginatedResult<PaymentListItem> page)
      : this._(status: PaymentListStatus.loaded, page: page);

  PaymentListState.error(String message)
      : this._(
          status: PaymentListStatus.error,
          page: PaginatedResult.empty<PaymentListItem>(),
          errorMessage: message,
        );

  @override
  List<Object?> get props => [status, page.currentPage, page.results.length, errorMessage];
}
