import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:labs/labs.dart';
import 'package:labs_web/labs_web.dart';

extension Ext on BuildContext {
  AppLocalizations? get localizedText {
    return AppLocalizations.of(this);
  }

  NativeButtonArguments buttonArg({
    ActionCallback? callback,
    VoidCallback? firstCallback,
    String? text,
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
        color: textColor ?? theme.colorScheme.background,
      ),
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
