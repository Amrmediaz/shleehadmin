import 'package:flutter/widgets.dart';

import 'generated/app_localizations.dart';

/// Shorthand: `context.l10n.someKey` instead of
/// `AppLocalizations.of(context)!.someKey`.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
