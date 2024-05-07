import 'package:client/src/blocs/routing/locator.dart';
import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/modules/models/misc.dart';
import 'package:client/src/modules/services/system/navigation_service.dart';
import 'package:client/src/views/flow/base.dart';
import 'package:client/src/views/flow/screens/auto_start/page_init.dart';
import 'package:client/src/views/flow/screens/secure_start/page_init.dart';
import 'package:client/src/views/flow/screens/session.completed.dart';
import 'package:client/src/views/flow/screens/session_failed.dart';
import 'package:client/src/views/forbidden/not_found.dart';
import 'package:client/src/views/landing/base.dart';
import 'package:client/src/views/root/base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';

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
              child: const StartDemo(),
            ),
          ),
          ShellRoute(
            navigatorKey: locator<NavigationService>().flowKey,
            builder: (context, state, child) => builder(
              context,
              state: state,
              child: FlowScaffold(
                method: state.pathParameters['method'] as String,
                child: child,
              ),
            ),
            routes: [
              GoRoute(
                name: RouteNames.flow.name,
                path: RouteNames.flow.route,
                pageBuilder: (context, state) => pageBuilder(
                  context,
                  state,
                  child: emptyView,
                ),
                routes: [
                  GoRoute(
                    name: RouteNames.secureStart.name,
                    path: RouteNames.secureStart.route,
                    pageBuilder: (context, state) => pageBuilder(
                      context,
                      state,
                      child: InitSecureStart(
                        method: state.pathParameters['method'] as String,
                      ),
                    ),
                  ),
                  GoRoute(
                    name: RouteNames.autoStart.name,
                    path: RouteNames.autoStart.route,
                    pageBuilder: (context, state) => pageBuilder(
                      context,
                      state,
                      child: InitAutoStart(
                        method: state.pathParameters['method'] as String,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: RouteNames.flowFailed.name,
            path: RouteNames.flowFailed.route,
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: FlowFailure(
                message: state.extra is! String ? null : state.extra as String,
                method: state.pathParameters['method'] as String,
                technical: state.extra is bool ? state.extra as bool : false,
              ),
            ),
          ),
          GoRoute(
            name: RouteNames.success.name,
            path: RouteNames.success.route,
            redirect: (context, state) {
              if (state.extra is! FlowSuccess) {
                return '/flow/${state.pathParameters['method'] ?? 'identification'}/failed';
              }
              return null;
            },
            pageBuilder: (context, state) => pageBuilder(
              context,
              state,
              child: FlowSucceeded(
                method: state.pathParameters['method'] as String,
                flow: state.extra as FlowSuccess,
              ),
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
