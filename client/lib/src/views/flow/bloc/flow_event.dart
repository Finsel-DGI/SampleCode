import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/blocs/session/logic.dart';
import 'package:client/src/blocs/session/state.dart';
import 'package:client/src/modules/models/auto_pasby_response.dart';
import 'package:client/src/modules/models/flow_check_response.dart';
import 'package:client/src/modules/models/misc.dart';
import 'package:client/src/modules/models/secure_start_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';

mixin FlowEvents {
  void cancelFlow(BuildContext context, WidgetRef ref, String id) async {
    context.goNamed(RouteNames.landingRoute.name);
  }

  void failure(BuildContext context,
      {String? error, required String method}) async {
    context.goNamed(RouteNames.flowFailed.name,
        pathParameters: {
          "method": method,
        },
        extra: error);
  }

  void matchAuthFlow(BuildContext context) {
    if (kIsWeb && Responsive.isMobile(context)) {
      context.goNamed(RouteNames.autoStart.name, pathParameters: {
        "method": "identification",
      });
    } else {
      context.goNamed(RouteNames.secureStart.name, pathParameters: {
        "method": "identification",
      });
    }
  }

  void matchConfirmationFlow(BuildContext context) {
    if (kIsWeb && Responsive.isMobile(context)) {
      // this mode is not supported without a nin reference
    } else {
      context.goNamed(RouteNames.secureStart.name, pathParameters: {
        "method": "signing",
      });
    }
  }

  void handleSuccess(
    WidgetRef ref,
    BuildContext context,
    FlowResponse response,
    String method,
    String payload,
  ) {
    context.goNamed(
      RouteNames.success.name,
      pathParameters: {
        "method": method,
      },
      extra: FlowSuccess(
        name: method == 'identification' ? response.data.claims?.naming?.name ?? '' : response.data.username ?? '',
        user: response.data.user,
        content: payload,
      ),
    );
  }

  Future<void> secureStart(BuildContext context, WidgetRef ref,
      {ValueChanged<String>? onFailed,
      required ValueChanged<SecureStartResponse> onLoaded}) async {
    var cred = ref.read(logicRepositoryProvider);
    try {
      var response = await cred.secureStart(ref.read(app).identificationPayload.text);
      onLoaded(response);
      return;
    } on CustomException catch (e) {
      Logging.log.e(e.errorMessage);
      if (onFailed != null) onFailed(e.errorMessage);
    } catch (e) {
      Logging.log.e("Unreferenced error: $e");
      if (onFailed != null) onFailed('Technical error');
    }
  }

  Future<void> secureSign(BuildContext context, WidgetRef ref,
      {ValueChanged<String>? onFailed,
      required ValueChanged<SecureStartResponse> onLoaded}) async {
    var cred = ref.read(logicRepositoryProvider);
    try {
      var response = await cred.secureConfirmation(ref.read(app).signaturePayload.text);
      onLoaded(response);
      return;
    } on CustomException catch (e) {
      Logging.log.e(e.errorMessage);
      if (onFailed != null) onFailed(e.errorMessage);
    } catch (e) {
      Logging.log.e("Unreferenced error: $e");
      if (onFailed != null) onFailed('Technical error');
    }
  }

  Future<void> autoStart(BuildContext context, WidgetRef ref,
      {ValueChanged<String>? onFailed,
      required ValueChanged<AutoPasbyResponse> onLoaded}) async {
    var cred = ref.read(logicRepositoryProvider);
    try {
      var response = await cred.autoStart(ref.read(app).identificationPayload.text);
      onLoaded(response);
      return;
    } on CustomException catch (e) {
      Logging.log.e(e.errorMessage);
      if (onFailed != null) onFailed(e.errorMessage);
    } catch (e) {
      Logging.log.e("Unreferenced error: $e");
      if (onFailed != null) onFailed(e.toString());
    }
  }
}
