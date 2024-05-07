import 'package:anydrawer/anydrawer.dart';
import 'package:flutter/material.dart';

class DrawerBuild {
  static void show(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    AnyDrawerController? controller,
    VoidCallback? onOpen,
    VoidCallback? onClose,
    DrawerSide side = DrawerSide.right,
    bool closeOnClickOutside = true,
    bool dragEnabled = true,
    double? borderRadius,
    double? maxDragExtent,
    double? widthPercentage,
  }) {
    return showDrawer(
      context,
      builder: builder,
      config: DrawerConfig(
        side: side,
        widthPercentage: widthPercentage,
        maxDragExtent: maxDragExtent ?? .8,
        closeOnClickOutside: closeOnClickOutside,
        closeOnBackButton: true,
        closeOnEscapeKey: true,
        closeOnResume: true,
        dragEnabled: dragEnabled,
        borderRadius: borderRadius ?? 4,
        backdropOpacity: .5,
      ),
      onClose: onClose,
      onOpen: onOpen,
      controller: controller
    );
  }
}
