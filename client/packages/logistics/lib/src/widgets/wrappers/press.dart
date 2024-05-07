import 'package:flutter/material.dart';

class SplashPressButtonWrapper extends StatelessWidget {
  final bool imageSplash, circularSplash;
  final Widget child;
  final Color? highLight, splashColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  const SplashPressButtonWrapper(
      {Key? key,
      this.imageSplash = false,
      this.circularSplash = false,
      required this.child,
      this.onTap,
      this.highLight,
      this.splashColor,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var highlight =
        highLight ?? Theme.of(context).highlightColor.withOpacity(.2);
    if (circularSplash) {
      return InkResponse(
          highlightColor: highlight,
          splashColor: splashColor,
          onTap: onTap,
          child: child);
    }

    return InkWell(
        highlightColor: highlight,
        splashColor: splashColor,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child);
  }
}


class NativeInkWell extends StatelessWidget {
  final double? radius;
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final MouseCursor? cursor;
  final bool disable, circular;
  final String? tooltip;
  const NativeInkWell(
      {Key? key,
      this.radius,
      required this.child,
      this.onTap,
      this.disable = false,
      this.circular = false,
      this.cursor,
      this.onHover,
      this.onLongPress,
      this.tooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: disable ? null : onTap,
        onHover: onHover,
        customBorder: circular ? const CircleBorder() : null,
        onLongPress: disable ? null : onLongPress,
        mouseCursor: disable ? SystemMouseCursors.forbidden : cursor,
        borderRadius: BorderRadius.circular(radius ?? 18),
        child: Opacity(
            opacity: disable ? .4 : 1,
            child: Tooltip(message: tooltip ?? '', child: child)));
  }
}
