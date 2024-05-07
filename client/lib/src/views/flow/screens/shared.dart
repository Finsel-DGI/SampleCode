import 'package:client/src/blocs/session/state.dart';
import 'package:client/src/modules/enums/default.dart';
import 'package:client/src/modules/models/flow_abstract.dart';
import 'package:client/src/views/flow/bloc/flow_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';

import '../component/link.listner.dart';
import 'session_confirm.dart';

class PasbyFlowMechanismScaffold<T> extends HookConsumerWidget with FlowEvents {
  const PasbyFlowMechanismScaffold(
      {super.key,
      required this.mode,
      this.flow,
      required this.init,
      required this.child});

  final String mode;
  final Widget child;
  final PasbyFlow? flow;
  final ActionCallback<void> init;

  @override
  Widget build(BuildContext context, ref) {
    var action = useState(ActionState.waiting);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted) return;
        await init();
      });
      return null;
    }, const []);

    return Stack(
      children: [
        if (flow != null) ...[
          Opacity(
            opacity: .1,
            child: RequestListener(
              onReceived: (state) async {
                switch (state) {
                  case ActionState.canceled:
                    failure(context, method: mode, error: 'Request cancelled');
                    break;
                  default:
                    action.value = state;
                }
              },
              onError: () async {
                cancelFlow(context, ref, flow!.identifier);
                failure(context, method: mode, error: 'Request cancelled');
              },
              onCompleted: (value) async {
                handleSuccess(
                  ref,
                  context,
                  value,
                  mode,
                  mode == 'identification'
                      ? ref.read(app).identificationPayload.text
                      : ref.read(app).signaturePayload.text,
                );
              },
              flowID: flow!.identifier,
            ),
          ),
          if (flow != null && action.value == ActionState.waiting) ...[
            child,
          ],
          if (flow != null && action.value == ActionState.session) ...[
            ConfirmSessionRequest(session: flow!),
          ],
        ],
      ],
    );
  }
}
