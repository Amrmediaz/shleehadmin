import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/language_toggle_button.dart';
import '../features/auth/cubit/auth_cubit.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/bookings/presentation/bookings_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/payment/presentation/payment_list_screen.dart';
import '../l10n/l10n_extensions.dart';

/// Owner shell shown after a successful login: bottom-nav between the
/// Dashboard, Bookings and Payments tabs. Add more tabs here as more
/// AppOwner areas get built out.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _tabs = [
    DashboardScreen(),
    BookingsScreen(),
    PaymentListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titles = [l10n.appTitleOwner, l10n.bookings, l10n.payments];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index]),
        actions: [
          const LanguageToggleButton(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l10n.logout,
            onPressed: () async {
              await context.read<AuthCubit>().logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(index: _index, children: _tabs),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: l10n.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event_note_outlined),
            selectedIcon: const Icon(Icons.event_note),
            label: l10n.bookings,
          ),
          NavigationDestination(
            icon: const Icon(Icons.payments_outlined),
            selectedIcon: const Icon(Icons.payments),
            label: l10n.payments,
          ),
        ],
      ),
    );
  }
}
