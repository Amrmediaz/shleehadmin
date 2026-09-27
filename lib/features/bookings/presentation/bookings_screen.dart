import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n_extensions.dart';
import '../cubit/booking_list_cubit.dart';
import '../data/bookings_repository.dart';
import 'booking_list_view.dart';

/// Bookings tab: "Paid" and "Not Paid" sub-tabs, each independently
/// paginated via PaidBookingList / NotPaidBookingList.
class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _repository = BookingsRepository();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          tabs: [
            Tab(text: l10n.paid),
            Tab(text: l10n.notPaid),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocProvider(
                create: (_) => BookingListCubit(
                  fetchPage: ({required page}) => _repository.getPaidBookings(page: page),
                ),
                child: BookingListView(emptyMessage: l10n.noPaidBookings),
              ),
              BlocProvider(
                create: (_) => BookingListCubit(
                  fetchPage: ({required page}) => _repository.getNotPaidBookings(page: page),
                ),
                child: BookingListView(emptyMessage: l10n.noUnpaidBookings),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
