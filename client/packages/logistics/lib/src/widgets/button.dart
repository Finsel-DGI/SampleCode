import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/link.dart';
import 'package:seo_renderer/renderers/link_renderer/link_renderer_vm.dart';


class DefaultTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? textSize;
  final Color? textColor;
  final bool busy, inactive;
  final Widget? child;
  final FontWeight? textWeight;
  final TextStyle? style;
  const DefaultTextButton(
      {Key? key,
      this.text = '',
      this.onTap,
      this.textSize,
      this.textColor,
      this.busy = false,
      this.inactive = false,
      this.child,
      this.textWeight,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: inactive ? null : onTap,
        child: Opacity(
          opacity: inactive ? .3 : 1,
          child: busy
              ? SpinKitCircle(
                  size: textSize ?? 14,
                  color: textColor ?? Theme.of(context).primaryColor,
                )
              : child ??
                  Text(
                    text,
                    style: style ??
                        defaultStyle(
                            size: textSize ?? 11.8.sp,
                            weight: textWeight,
                            color: textColor ?? Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline),
                  ),
        ));
  }
}


class WebNativeButton extends HookWidget {
  final String text;
  final VoidCallback? onLongPress, firstCallback;
  final ActionCallback? onTap;
  final double? width, height, textSize, size, radius, borderWidth;
  final Color? bckColor, textColor, borderColor, inactiveColor;
  final bool inactive, bouncing;
  final Widget? child;
  final ValueChanged<bool>? onHover;
  final TextStyle? style;
  final bool circular;
  final bool? busy;
  final EdgeInsets? margin, padding;
  final String? tooltip;
  final double? loaderSize;
  final Alignment alignment;
  const WebNativeButton(
      {Key? key,
      this.text = '',
      required this.onTap,
      this.width,
      this.firstCallback,
      this.loaderSize,
      this.bckColor,
      this.height,
      this.textSize,
      this.textColor = Colors.white,
      this.inactive = false,
      this.busy,
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
      this.alignment = Alignment.center})
      : assert(size != null && (width == null && height == null) ||
            size == null && (width != null || width == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var background = bckColor ?? Theme.of(context).highlightColor;
    var actual = bckColor ?? Theme.of(context).highlightColor;

    var busyLoc = useState(false);

    Future<void> handleTap() async {
      if (busy == null) (busyLoc.value = true);
      if (firstCallback != null) firstCallback!();
      if (onTap != null) await onTap!();
      if (context.mounted) {
        if (busy == null) (busyLoc.value = false);
      }
    }

    Widget widget({required Widget child}) {
      return NativeInkWell(
        tooltip: tooltip,
        circular: circular,
        onTap: inactive || (busy ?? busyLoc.value)
            ? null
            : () async => await handleTap(),
        onLongPress: onLongPress,
        onHover: (value) {
          if (onHover != null) onHover!(value);
          (background = value ? background.lighter(40) : actual);
        },
        disable: (busy ?? busyLoc.value) || inactive,
        radius: radius,
        child: child,
      );
    }

    return Padding(
      padding: margin ?? const EdgeInsets.only(top: 4.0, left: 10, right: 10.0),
      child: widget(
        child: Container(
          width: size ?? width ?? double.infinity,
          height: height ?? size ?? 40,
          padding: padding,
          decoration: BoxDecoration(
              color: inactive
                  ? inactiveColor ?? const Color(0xFFFFFFFF).withOpacity(0.4)
                  : background,
              shape: circular ? BoxShape.circle : BoxShape.rectangle,
              border: Border.all(
                  color: borderColor ?? Theme.of(context).highlightColor,
                  width: borderWidth ?? 0),
              borderRadius:
                  circular ? null : BorderRadius.circular(radius ?? 6)),
          alignment: alignment,
          child: busy ?? busyLoc.value
              ? GFLoader(
                  loaderColorOne: context.theme.colorScheme.secondary,
                  loaderColorTwo: context.theme.colorScheme.primary,
                  loaderColorThree: context.theme.colorScheme.tertiary,
                  type: GFLoaderType.circle,
                  size: loaderSize ?? GFSize.MEDIUM,
                )
              : child ??
                  Text(
                    text,
                    style: style ??
                        defaultStyle(
                          size: textSize ?? 14,
                          weight: FontWeight.w500,
                          color: inactive
                              ? Colors.grey.withOpacity(0.6)
                              : textColor,
                        ),
                  ),
        ),
      ),
    );
  }
}

class WebButton extends StatelessWidget {
  final NativeButtonArguments args;
  const WebButton({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    Widget wrapper({required Widget child}) {
      if (args.link == null) return child;

      return Link(
        uri: Uri.parse(args.link!),
        target: LinkTarget.defaultTarget,
        builder: (BuildContext context, Future<void> Function()? followLink) {
          return LinkRenderer(
            text: args.text,
            href: args.link ?? '',
            child: child,
          );
        },
      );
    }

    return Link(
        uri: args.link == null ? null : Uri.parse(args.link!),
        target: LinkTarget.defaultTarget,
        builder: (BuildContext context, Future<void> Function()? followLink) {
          return LinkRenderer(
            text: args.text,
            href: args.link ?? '',
            child: WebNativeButton(
              onTap: args.onTap ??
                  (followLink == null ? null : () async => await followLink()),
              text: args.text,
              onHover: args.onHover,
              width: args.width,
              height: args.height,
              textColor: args.textColor,
              size: args.size,
              busy: args.busy,
              loaderSize: args.loaderSize,
              radius: args.radius,
              firstCallback: args.firstCallback,
              borderColor: args.borderColor,
              bckColor: args.bckColor,
              borderWidth: args.borderWidth,
              alignment: args.alignment,
              bouncing: args.bouncing,
              inactive: args.inactive,
              inactiveColor: args.inactiveColor,
              style: args.style,
              textSize: args.textSize,
              circular: args.circular,
              margin: args.margin,
              padding: args.padding,
              tooltip: args.tooltip,
              onLongPress: args.onLongPress,
              child: args.child,
            ),
          );
        });
  }
}
