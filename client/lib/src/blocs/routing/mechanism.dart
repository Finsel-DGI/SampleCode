import 'package:client/src/blocs/routing/locator.dart';
import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/modules/services/system/navigation_service.dart';
import 'package:client/src/views/forbidden/not_found.dart';
import 'package:client/src/views/root/base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:labs/labs.dart';

final router = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.landingRoute.route,
    navigatorKey: locator<NavigationService>().navigatorKey,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: locator<NavigationService>().rootKey,
        builder: (context, state, child) => builder(
          context,
          state: state,
          child: RootTemplate(
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            name: RouteNames.landingRoute.name,
            path: RouteNames.landingRoute.route,
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: emptyView,
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => builder(
      context,
      state: state,
      child: const ForbiddenRoute(),
    ),
  );
});

pageBuilder(BuildContext context, GoRouterState? state,
    {required Widget child}) {
  return NoTransitionPage(child: child);
}

Widget builder(BuildContext context,
    {required Widget child, GoRouterState? state}) {
  if (state != null) {
    Logging.log.i("Path: ${state.pathParameters}");
  }
  return child;
}
