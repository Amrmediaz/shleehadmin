import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../l10n/l10n_extensions.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

/// Dashboard tab: shows the owner-level stats from GET /AppOwner/HomePage.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..load(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) return const LoadingView();
          if (state.status == HomeStatus.error) {
            return ErrorView(
              message: state.errorMessage ?? context.l10n.somethingWentWrong,
              onRetry: () => context.read<HomeCubit>().load(),
            );
          }

          final s = state.stats;
          final l10n = context.l10n;
          return RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().load(),
                child: GridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: [
                    StatCard(
                      label: l10n.customers,
                      value: '${s.customers}',
                      icon: Icons.people_outline,
                      color: Colors.indigo,
                    ),
                    StatCard(
                      label: l10n.chalets,
                      value: '${s.buildings}',
                      icon: Icons.villa_outlined,
                      color: Colors.teal,
                    ),
                    StatCard(
                      label: l10n.hotelBuildings,
                      value: '${s.hotelBuildings}',
                      icon: Icons.apartment_outlined,
                      color: Colors.deepPurple,
                    ),
                    StatCard(
                      label: l10n.buildingOwners,
                      value: '${s.buildingOwners}',
                      icon: Icons.badge_outlined,
                      color: Colors.brown,
                    ),
                    StatCard(
                      label: l10n.bookings,
                      value: '${s.bookingCount}',
                      icon: Icons.event_available_outlined,
                      color: Colors.orange,
                    ),
                    StatCard(
                      label: l10n.hotelBookings,
                      value: '${s.hotelBookingCount}',
                      icon: Icons.hotel_outlined,
                      color: Colors.pink,
                    ),
                    StatCard(
                      label: l10n.revenue,
                      value: s.amount.toStringAsFixed(2),
                      icon: Icons.payments_outlined,
                      color: Colors.green,
                    ),
                    StatCard(
                      label: l10n.hotelRevenue,
                      value: s.hotelAmount.toStringAsFixed(2),
                      icon: Icons.account_balance_wallet_outlined,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
