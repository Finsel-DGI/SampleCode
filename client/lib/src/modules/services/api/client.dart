import 'package:client/src/modules/models/secure_start_response.dart';
import 'package:flutter/foundation.dart';
import 'package:logistics/logistics.dart';
import '../../models/auto_pasby_response.dart';
import '../../models/flow_check_response.dart';

class Api {
  /// todo: change this proxy to one you have complete access to or you can create a proxy for your use with this example: https://stackoverflow.com/a/32704647
  static const _proxy = "https://my.proxy.server/";

  static const _pasbySecureStart = "/api/start/securely";

  /// open automatically
  static const _pasbyAutoStart = "/api/start/auto";

  /// 'confirm' | 'sign' - actions
  static const _pasbySign = "/api/start/signature";

  static const _pasbyCancel = "/api/flow/cancel";

  /// ping auth flow
  static const _pasbyPing = "/api/flow/ping";

  /// todo: modify to match your own servers if you are working on this service yourself.
  static const _api = "https://my.demo.server.api";
  /// for dev mode use a localhost server
  static const _apiDebug = "http://localhost:[port]";

  Api() {
    bool debug = kDebugMode;
    // bool debug = kDebugMode;
    _requester = 
    CallMyApis(url: debug ? _apiDebug : _api, debug: debug, proxy: _proxy);
  }

  late CallMyApis _requester;

  /// pasby only
  Future<SecureStartResponse> pasbySecureStart(String payload) async {
    var response = await CallMyApis.commit(
      () async => await _requester.dioPost(
        endpoint: _pasbySecureStart,
        body: {"payload": payload, "action": 'signup'},
      ),
    );
    return SecureStartResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<AutoPasbyResponse> pasbyAutoStart(String payload) async {
    var response = await CallMyApis.commit(
      () async => await _requester.dioPost(
        endpoint: _pasbyAutoStart,
        body: {"payload": payload, "action": 'signup'},
      ),
    );
    return AutoPasbyResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<SecureStartResponse> confirmWithPasby(String payload) async {
    var response = await CallMyApis.commit(
      () async => await _requester.dioPost(
        endpoint: _pasbySign,
        body: {"payload": payload},
      ),
    );
    return SecureStartResponse.fromJson(response as Map<String, dynamic>);
  }

  Future<void> pasbyFlowCancel(String identifier) async {
    await CallMyApis.commit(
      () async => await _requester.dioPost(
        endpoint: _pasbyCancel,
        body: {"request": identifier},
      ),
    );
  }

  /// ping stuff
  Future<FlowResponse> _pasbyFlowPing(String identifier) async {
    var response = await CallMyApis.commit(
      () async => await _requester.dioPost(
        endpoint: _pasbyPing,
        body: {"request": identifier},
      ),
    );
    // Logging.log.wtf("Data seen: $response");
    return FlowResponse.fromJson(response as Map<String, dynamic>);
  }

  Stream<FlowResponse> listenToAuth(String identifier) async* {
    try {
      do {
        var res = await _pasbyFlowPing(identifier);
        yield res;
        await Future.delayed(const Duration(milliseconds: 2));
      } while (true);
    } catch (e) {
      rethrow;
    }
  }

  /// ping close
}
