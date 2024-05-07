import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/views/flow/bloc/flow_event.dart';
import 'package:client/src/views/flow/bloc/flow_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class FlowScaffold extends HookConsumerWidget {
  const FlowScaffold({super.key, required this.child, required this.method});

  final Widget child;
  final String method;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      width: 600,
      constraints: const BoxConstraints(minHeight: 540),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: context.theme.colorScheme.tertiary.withAlpha(40),
          width: 1.4,
        ),
      ),
      margin: padAsymmetric(),
      padding: padAsymmetric(horiz: 30, vert: 2.4.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(),
          context.localizedText!.pasby(method).textView(
                textAlign: TextAlign.center,
                padding: EdgeInsets.only(
                  bottom: 1.8.h,
                  top: 2.8.h,
                ),
                style: appTextStyle(
                  family: FontFamily.libre,
                  variation: 780,
                  size: getProportionateScreenHeight(30.4),
                  color: context.colorScheme.tertiary,
                ),
              ),
          child,
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget with FlowState, FlowEvents {
  _Header();

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BackButton(
          onPressed: () async {
            context.goNamed(RouteNames.landingRoute.name);
          },
        ),
      ],
    );
  }
}
