import 'package:flutter/services.dart';

class BrowserSettingsService {

  Future<void> changeAppName(String value, Color color) async {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: value,
        primaryColor: color.value,
      )
    );
  }

  BrowserSettingsService();
}