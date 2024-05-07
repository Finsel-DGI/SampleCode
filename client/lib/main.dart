import 'package:client/src/blocs/routing/locator.dart';
import 'package:client/src/blocs/session/logic.dart';
import 'package:client/src/views/app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'sw', 'fr']);
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setPathUrlStrategy();
  await Prefs.init();
  final container = ProviderContainer();
  await container.read(logicRepositoryProvider).init();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ProviderScope(
        child: LocalizedApp(
          delegate,
          const Application(),
        ),
      ),
    ),
  );
}
