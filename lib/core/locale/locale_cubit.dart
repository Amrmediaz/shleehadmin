import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the app's current [Locale]. Defaults to Arabic, remembers the
/// owner's choice across restarts via shared_preferences.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar')) {
    _restore();
  }

  static const _prefsKey = 'app_locale';
  static const supportedLocales = [Locale('ar'), Locale('en')];

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    if (saved != null && supportedLocales.any((l) => l.languageCode == saved)) {
      emit(Locale(saved));
    }
  }

  Future<void> toggle() => setLocale(state.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }
}
