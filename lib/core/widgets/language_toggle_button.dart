import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n_extensions.dart';
import '../locale/locale_cubit.dart';

/// Small "EN" / "AR" pill that flips [LocaleCubit]'s locale. Drop into an
/// AppBar's `actions` (LoginScreen, AppShell).
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
    final isArabic = locale.languageCode == 'ar';
    return IconButton(
      tooltip: context.l10n.languageToggleTooltip,
      onPressed: () => context.read<LocaleCubit>().toggle(),
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.translate, size: 20),
          const SizedBox(width: 4),
          Text(
            isArabic ? 'EN' : 'AR',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
