import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/modules/models/flow_abstract.dart';
import 'package:client/src/views/flow/bloc/flow_event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';

class CancelFlowButton extends ConsumerWidget with FlowEvents {
  const CancelFlowButton(
      {super.key, required this.flow, this.textSize, this.margin});

  final PasbyFlow? flow;
  final double? textSize;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: margin ?? padNone(),
      child: DefaultTextButton(
        onTap: () {
          if (flow == null) return;
          cancelFlow(context, ref, flow!.identifier);
        },
        child: context.localizedText!.cancel.textView(
          style: appTextStyle(
            size: getProportionateScreenHeight(20),
            family: FontFamily.libre,
            variation: 340,
            color: context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
