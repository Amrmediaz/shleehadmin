import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/pagination_footer.dart';
import '../../../l10n/l10n_extensions.dart';
import '../cubit/booking_list_cubit.dart';
import '../cubit/booking_list_state.dart';
import 'booking_details_screen.dart';
import 'widgets/booking_list_tile.dart';

/// Paginated list of bookings, driven by whichever [BookingListCubit] is
/// provided above it (paid or not-paid — the cubit only differs in which
/// repository method it was built with).
class BookingListView extends StatelessWidget {
  const BookingListView({super.key, required this.emptyMessage});

  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingListCubit, BookingListState>(
      builder: (context, state) {
        if (state.status == BookingListStatus.loading) return const LoadingView();
        if (state.status == BookingListStatus.error) {
          return ErrorView(
            message: state.errorMessage ?? context.l10n.somethingWentWrong,
            onRetry: () => context.read<BookingListCubit>().refresh(),
          );
        }

        final page = state.page;
        if (page.results.isEmpty) {
          return EmptyView(message: emptyMessage, icon: Icons.event_busy_outlined);
        }

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => context.read<BookingListCubit>().refresh(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: page.results.length,
                  itemBuilder: (context, index) {
                    final booking = page.results[index];
                    return BookingListTile(
                      booking: booking,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookingDetailsScreen(bookingId: booking.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            if (page.pageCount > 1)
              PaginationFooter(
                currentPage: page.currentPage,
                pageCount: page.pageCount,
                onPrevious: page.hasPreviousPage ? () => context.read<BookingListCubit>().previousPage() : null,
                onNext: page.hasNextPage ? () => context.read<BookingListCubit>().nextPage() : null,
              ),
          ],
        );
      },
    );
  }
}
