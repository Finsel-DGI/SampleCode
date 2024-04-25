import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labs/labs.dart';

import 'settings.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier  implements AppSettingsInterface {

  SettingsController();

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService  = SettingsService();

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;
  Locale? _locale;
  Locale? get locale => _locale;

  // Allow Widgets to read the user's preferred ThemeMode.
  @override
  ThemeMode get themeMode => _themeMode;
  @override
  SettingsService get service => _settingsService;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  @override
  Future<void> loadSettings() async {
    _locale = await _settingsService.locale();
    _themeMode = await _settingsService.theme();
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  @override
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateAppLanguage(Locale? value) async {
    if (value == null) return;

    // Do not perform any work if new and old Locale are identical
    if (value == _locale) return;

    // Otherwise, store the new Locale in memory
    _locale = value;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateLanguage(value);
  }
}

final settingsProvider = ChangeNotifierProvider<SettingsController>((ref) {
  return SettingsController();
});