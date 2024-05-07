import 'package:client/gen/assets.gen.dart';
import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/modules/models/flow_abstract.dart';
import 'package:client/src/views/flow/component/cancellation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class ConfirmSessionRequest extends HookWidget {
  const ConfirmSessionRequest({super.key, required this.session});

  final PasbyFlow session;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        context.localizedText!.session('confirm').textView(
              textAlign: TextAlign.center,
              padding: EdgeInsets.only(
                top: 1.8.h,
                bottom: 2.8.h,
                left: 14,
                right: 14,
              ),
              style: appTextStyle(
                family: FontFamily.libre,
                size: getProportionateScreenHeight(20.4),
                variation: 400,
                color: context.colorScheme.tertiary,
              ),
            ),
        Assets.svg.usePasby.svg(
          height: getProportionateScreenHeight(240),
        ),

        CancelFlowButton(
          flow: session,
          margin: EdgeInsets.only(top: 8.8.h),
        ),
      ],
    );
  }
}
