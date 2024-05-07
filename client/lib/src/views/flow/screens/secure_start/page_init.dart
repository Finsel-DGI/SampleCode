import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/modules/models/secure_start_response.dart';
import 'package:client/src/views/flow/bloc/flow_event.dart';
import 'package:client/src/views/flow/bloc/flow_state.dart';
import 'package:client/src/views/flow/component/code.display.dart';
import 'package:client/src/views/flow/screens/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class InitSecureStart extends HookConsumerWidget with FlowState, FlowEvents {
  InitSecureStart({super.key, required this.method});

  final String method;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<SecureStartResponse?> flow = useState(null);
    return PasbyFlowMechanismScaffold(
      mode: method,
      init: () async {
        if(method == 'identification'){
           await secureStart(context, ref, onLoaded: (value) {
            if (!context.mounted) return;
            flow.value = value;
          }, onFailed: (e) {
            if (!context.mounted) return;
            failure(context, method: method);
          });
        } else if(method == 'signing'){
           await secureSign(context, ref, onLoaded: (value) {
            if (!context.mounted) return;
            flow.value = value;
          }, onFailed: (e) {
            if (!context.mounted) return;
            failure(context, method: method);
          });
        }
       
      },
      flow: flow.value,
      child: flow.value == null
          ? emptyView
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context.localizedText!.pasby('scan').textView(
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.only(
                        top: 1.8.h,
                        bottom: 2.8.h,
                        left: 14,
                        right: 14,
                      ),
                      style: appTextStyle(
                        size: getProportionateScreenHeight(20.4),
                        variation: 400,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                SeedCodeDisplay(
                  seeds: (flow.value)!.data.seeds,
                  margin: padAsymmetric(vert: 2.8.h, horiz: 0),
                )
              ],
            ),
    );
  }
}
