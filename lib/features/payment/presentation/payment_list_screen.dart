import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/pagination_footer.dart';
import '../../../l10n/l10n_extensions.dart';
import '../cubit/payment_list_cubit.dart';
import '../cubit/payment_list_state.dart';
import '../data/payment_list_item.dart';

/// Payments tab: paginated list from GET /AppOwner/PaymentList.
class PaymentListScreen extends StatelessWidget {
  const PaymentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentListCubit(),
      child: BlocBuilder<PaymentListCubit, PaymentListState>(
        builder: (context, state) {
          if (state.status == PaymentListStatus.loading) return const LoadingView();
          if (state.status == PaymentListStatus.error) {
            return ErrorView(
              message: state.errorMessage ?? context.l10n.somethingWentWrong,
              onRetry: () => context.read<PaymentListCubit>().refresh(),
            );
          }

          final page = state.page;
          if (page.results.isEmpty) {
            return EmptyView(message: context.l10n.noPayments, icon: Icons.receipt_long_outlined);
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context.read<PaymentListCubit>().refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: page.results.length,
                    itemBuilder: (context, index) => _PaymentTile(item: page.results[index]),
                  ),
                ),
              ),
              if (page.pageCount > 1)
                PaginationFooter(
                  currentPage: page.currentPage,
                  pageCount: page.pageCount,
                  onPrevious: page.hasPreviousPage ? () => context.read<PaymentListCubit>().previousPage() : null,
                  onNext: page.hasNextPage ? () => context.read<PaymentListCubit>().nextPage() : null,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.item});

  final PaymentListItem item;

  @override
  Widget build(BuildContext context) {
    final orderLabel = context.l10n.orderNumber(item.orderId);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.green.withOpacity(0.12),
          child: const Icon(Icons.receipt_outlined, color: Colors.green),
        ),
        title: Text(item.name.trim().isEmpty ? orderLabel : item.name.trim()),
        subtitle: Text('$orderLabel · ${item.phone}'),
        trailing: Text(
          '${item.cost}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
