import 'package:client/src/modules/services/theming/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labs/labs.dart';
import 'package:labs_web/labs_web.dart';
import 'package:sizer/sizer.dart';
import '../blocs/routing/mechanism.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    ref.read(settingsProvider.notifier).loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;
    var routing = ref.watch(router);
    var settings = ref.watch(settingsProvider);
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: AnimatedBuilder(
          animation: settings,
          builder: (context, child) {
            return Sizer(builder: (context, orientation, deviceType) {
              return MaterialApp.router(
                routerConfig: routing,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)?.appTitle ?? 'pasby™ Demo',
                supportedLocales: AppLocalizations.supportedLocales,
                scrollBehavior: CustomScrollBehavior(),
                scaffoldMessengerKey: globalSnackBarKey,
                locale: settings.locale ?? localizationDelegate.currentLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                shortcuts: {
                  LogicalKeySet(LogicalKeyboardKey.space):
                      const ActivateIntent(),
                },
                debugShowCheckedModeBanner: false,
                themeMode: settings.themeMode,
                theme: settings.service.lightMode(),
                darkTheme: settings.service.darkMode(),
              );
            });
          }),
    );
  }
}
