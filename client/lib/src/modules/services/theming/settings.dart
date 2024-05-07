import 'package:client/src/modules/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> theme() async {
    try {
      String? theme = Prefs.getString('theme');

      if (theme == null) return ThemeMode.light;

      if (theme == 'system') {
        return ThemeMode.system;
      } else if (theme == 'dark') {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } catch (_) {
      return ThemeMode.dark;
    }
  }

  Future<Locale?> locale() async {
    try {
      String? language = Prefs.getString('locale');

      if (language == null) return null;

      return Locale(language);
    } catch (_) {
      return null;
    }
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    await Prefs.saveString('theme', theme.name);
  }

  Future<void> updateLanguage(Locale value) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    await Prefs.saveString('locale', value.languageCode);
  }

  /// Loads the Native preferred DarkMode settings.
  ThemeData darkMode() {
    return ThemeData(
      useMaterial3: false,
      primaryIconTheme:
          ThemeData.dark().primaryIconTheme.copyWith(color: Colors.white),
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkBackground.lighter(10),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white,),
      appBarTheme: AppBarTheme(
        backgroundColor: darkCompliment,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontFamily: 'Inter',
            fontSize:
                SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 6.4.sp),
      ),
      cardColor: darkBackground.lighter(10),
      primaryColor: Colors.white,
      focusColor: DefColoring.focusColor,
      highlightColor: DefColoring.highlightColor,
      indicatorColor: Colors.white,
      colorScheme: const ColorScheme.dark()
          .copyWith(secondary: darkBackground.lighter(4)),
    );
  }

  ThemeData lightMode() {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: AppBarTheme(
          backgroundColor: lightCompliment,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontFamily: 'Inter',
            fontSize:
                SizerUtil.deviceType == DeviceType.mobile ? 13.sp : 6.4.sp,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
      ),
      primaryColor: Colors.black,
      indicatorColor: Colors.black,
      focusColor: DefColoring.focusColor,
      highlightColor: DefColoring.highlightColor,
      scaffoldBackgroundColor: DefColoring.lightbackground,
      colorScheme: const ColorScheme.light().copyWith(
        secondary: darkBackground.lighter(4),
        tertiary: DefColoring.otherColor,
        primary: DefColoring.highlightColor,
      ),
    );
  }
}
