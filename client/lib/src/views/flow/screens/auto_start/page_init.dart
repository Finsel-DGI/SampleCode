import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/modules/models/auto_pasby_response.dart';
import 'package:client/src/views/flow/bloc/flow_event.dart';
import 'package:client/src/views/flow/bloc/flow_state.dart';
import 'package:client/src/views/flow/screens/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class InitAutoStart extends HookConsumerWidget with FlowState, FlowEvents {
  InitAutoStart({super.key, required this.method});

  final String method;

  @override
  Widget build(BuildContext context, ref) {
    ValueNotifier<AutoPasbyResponse?> flow = useState(null);
    var disable = useState(false);

    return PasbyFlowMechanismScaffold(
      mode: method,
      init: () async {
        if (method == 'identification') {
          await autoStart(context, ref, onLoaded: (value) {
            if (!context.mounted) return;
            flow.value = value;
          }, onFailed: (e) {
            if (!context.mounted) return;
            failure(context, method: method);
          });
        } else if (method == 'signing') {
          /// cannot handle auto signature scope with a wildcard.
          /// To handle auto signature scope you are required to provide a user's nin.
        }
      },
      flow: flow.value,
      child: flow.value == null
          ? emptyView
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          context.localizedText!.pasby('auto').textView(
                textAlign: TextAlign.center,
                padding: EdgeInsets.only(
                  top: 1.8.h,
                  bottom: 4.8.h,
                  left: 14,
                  right: 14,
                ),
                style: appTextStyle(
                  family: FontFamily.libre,
                  size: getProportionateScreenHeight(21.4),
                  variation: 400,
                  color: context.colorScheme.tertiary,
                ),
              ),
          ConsoleButton(
            arg: context
                .buttonArg(
                  text: context.localizedText!.open,
                  textColor: Colors.white,
                  width: 320,
                  height: 58.7,
                  inactive: disable.value,
                  callback: () async {
                    disable.value = true;
                    // open the pasby url
                    await UrlService
                        .launchURL(flow.value!.data.uri, browser: true);
                    disable.value = true;
                  },
                )
                .copyWith(
                  inactiveColor: Colors.grey,
                  bckColor: context.colorScheme.tertiary,
                  margin: padAsymmetric(vert: 8.8.h),
                ),
          ),
        ],
      ),
    );
  }
}
