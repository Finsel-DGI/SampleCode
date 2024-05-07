import 'package:client/src/modules/models/auto_pasby_response.dart';
import 'package:client/src/modules/models/flow_check_response.dart';
import 'package:client/src/modules/models/secure_start_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics/logistics.dart';

import '../../modules/services/api/client.dart';

final logicRepositoryProvider = Provider<LogicRepository>((ref) {
  return LogicRepository();
});

abstract class LogicRepo {
  /// handling
  Future<void> cancelFlow(String identifier);

  Stream<FlowResponse> changes(String identifier);

  ///authentication
  Future<SecureStartResponse> secureStart(String payload);

  Future<AutoPasbyResponse> autoStart(String payload);

  /// signing
  Future<SecureStartResponse> secureConfirmation(String payload);

  /// autoSigning does not exist on mobile devices. You need to have the users nin to create such a signature flow
}

class LogicRepository implements LogicRepo {
  LogicRepository();
  late Api _api;

  Future<void> init() async {
    _api = Api();
  }

  @override
  Future<SecureStartResponse> secureStart(String payload) async {
    return await _api.pasbySecureStart(payload);
  }

  @override
  Future<AutoPasbyResponse> autoStart(String payload) async {
    return await _api.pasbyAutoStart(payload);
  }

  @override
  Future<void> cancelFlow(String identifier) async {
    try {
      await _api.pasbyFlowCancel(identifier);
    } on CustomException catch (e) {
      Logging.log.e(e.errorMessage);
    } catch (e) {
      Logging.log.e("Cancellation error: $e");
    }
  }

  @override
  Future<SecureStartResponse> secureConfirmation(String payload) async {
    return await _api.confirmWithPasby(payload);
  }

  @override
  Stream<FlowResponse> changes(String identifier) {
    return _api.listenToAuth(identifier);
  }
}
