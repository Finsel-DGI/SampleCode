import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

class MenuArgs {
  final String name;
  final String route, link;
  MenuArgs({
    required this.route,
    required this.name,
    this.link = "",
  });
}

class TextHighlightObject {
  final String text;
  final VoidCallback? onPressed;
  final TextStyle? style;
  final Color? color, decorationColor;
  final TextDecoration? decoration;

  TextHighlightObject({
    required this.text,
    this.onPressed,
    this.style,
    this.decoration,
    this.color,
    this.decorationColor,
  });
}

class OptionMenuItem<T> {
  final T? value;
  final String text, subtext;
  final Widget? icon;
  final Color? textColor;
  final VoidCallback? onPressed;
  OptionMenuItem({
    required this.text,
    this.textColor,
    this.value,
    this.subtext = '',
    this.icon,
    this.onPressed,
  });

  @override
  String toString() {
    return "$text, value = $value";
  }
}

class NativeButtonArguments {
  final String text;
  final VoidCallback? onLongPress, firstCallback;
  ActionCallback? onTap;
  final double? width, height, textSize, loaderSize, size, radius, borderWidth;
  final Color? bckColor, textColor, borderColor, inactiveColor;
  bool inactive, bouncing;
  bool? busy;
  final Widget? child, loader;
  final ValueChanged<bool>? onHover;
  final TextStyle? style;
  final FontWeight? textWeight;
  final bool circular;
  final EdgeInsets? margin, padding;
  final String? tooltip;
  final Alignment alignment;
  final String? link;

  NativeButtonArguments({
    this.text = '',
    this.onTap,
    this.link,
    this.loader,
    this.width,
    this.bckColor,
    this.height,
    this.loaderSize,
    this.textWeight,
    this.firstCallback,
    this.textSize,
    this.textColor = Colors.white,
    this.busy = false,
    this.inactive = false,
    this.style,
    this.child,
    this.radius,
    this.borderWidth,
    this.borderColor,
    this.circular = false,
    this.size,
    this.margin,
    this.padding,
    this.tooltip,
    this.inactiveColor,
    this.onLongPress,
    this.bouncing = true,
    this.onHover,
    this.alignment = Alignment.center,
  });
}
