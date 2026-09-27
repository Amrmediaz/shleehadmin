import 'package:flutter/widgets.dart';

import '../../../core/models/paginated_result.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../l10n/l10n_extensions.dart';
import 'payment_list_item.dart';

class PaymentRepository {
  PaymentRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  /// Calls POST /AppOwner/OutPayment to enable payout/payment handling for
  /// a given booking. Requires the owner to be authenticated (Bearer token).
  ///
  /// `paymentType` mirrors the swagger example (`{"bookingId": 98,
  /// "paymentType": 2}`). The exact meaning of each paymentType value isn't
  /// documented yet — update [PaymentType] once confirmed.
  Future<void> enableBookingPayment({
    required int bookingId,
    required int paymentType,
  }) async {
    await _apiClient.postEnvelope(
      ApiEndpoints.outPayment,
      body: {
        'bookingId': bookingId,
        'paymentType': paymentType,
      },
    );
  }

  /// POST /AppOwner/PaymentList — paginated payment/transaction history.
  /// Body is `{"page": int, "pageSize": int}` (confirmed via swagger).
  Future<PaginatedResult<PaymentListItem>> getPaymentList({int page = 1, int pageSize = 10}) async {
    final message = await _apiClient.postEnvelope(
      ApiEndpoints.paymentList,
      body: {'page': page, 'pageSize': pageSize},
    );
    return PaginatedResult.fromJson(message, PaymentListItem.fromJson);
  }
}

/// Placeholder for the paymentType enum used by the OutPayment endpoint.
/// Real data observed in PaymentList shows both 1 and 2 in use, but their
/// meaning isn't documented — update these labels once the backend
/// confirms what each number means.
enum PaymentType {
  type1(1),
  type2(2);

  const PaymentType(this.value);

  final int value;
}

extension PaymentTypeLabel on PaymentType {
  String label(BuildContext context) {
    switch (this) {
      case PaymentType.type1:
        return context.l10n.paymentTypeOption1;
      case PaymentType.type2:
        return context.l10n.paymentTypeOption2;
    }
  }
}
