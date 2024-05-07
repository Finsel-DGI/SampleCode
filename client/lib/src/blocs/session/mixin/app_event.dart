import 'package:anydrawer/anydrawer.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/views/drawer/modify_flow.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';

mixin AppEvent {
  void toggleSettings(
      BuildContext context, WidgetRef ref, AnyDrawerController controller) {
    context.showDrawer(
        controller: controller,
        widthPercentage: Responsive.isMobile(context) ? .99 : .50,
        borderRadius: .8,
        builder: (context) {
          return ModifyFlowDrawerBase(
            controller: controller,
          );
        });
  }
}
