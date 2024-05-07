import 'package:anydrawer/anydrawer.dart';
import 'package:client/src/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logistics/logistics.dart';

extension Ext on BuildContext {
  AppLocalizations? get localizedText {
    return AppLocalizations.of(this);
  }

  NativeButtonArguments buttonArg({
    ActionCallback? callback,
    VoidCallback? firstCallback,
    String? text,
    String? link,
    Color? textColor,
    Widget? child,
    double? height,
    double textSize = 14.2,
    double? weight,
    double? loaderSize,
    double? width,
    bool inactive = false,
  }) {
    return NativeButtonArguments(
      onTap: callback,
      text: text ?? 'Continue',
      style: appTextStyle(
        size: textSize,
        variation: weight ?? 740,
        color: textColor ?? Colors.black,
      ),
      link: link,
      bckColor: theme.buttonTheme.colorScheme?.background,
      height: height ?? 48,
      width: width ?? 140,
      radius: 6,
      child: child,
      inactive: inactive,
      loaderSize: loaderSize,
      bouncing: false,
      borderColor: inactive
          ? Colors.transparent
          : theme.buttonTheme.colorScheme?.background,
    );
  }

  void showDrawer(
      {required Widget Function(BuildContext) builder,
      AnyDrawerController? controller,
      VoidCallback? onOpen,
      VoidCallback? onClose,
      DrawerSide side = DrawerSide.right,
      bool closeOnClickOutside = true,
      bool dragEnabled = true,
      double? widthPercentage,
      double? borderRadius}) {
    return DrawerBuild.show(
      this,
      builder: builder,
      borderRadius: borderRadius,
      controller: controller,
      onOpen: onOpen,
      dragEnabled: dragEnabled,
      onClose: onClose,
      side: side,
      widthPercentage: widthPercentage,
      closeOnClickOutside: closeOnClickOutside,
    );
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    var renderObject = currentContext?.findRenderObject();
    var matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      var rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);
      return rect;
    } else {
      return null;
    }
  }
}
