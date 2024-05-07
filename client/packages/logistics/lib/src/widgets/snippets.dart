import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

Widget get emptyView => const SizedBox.shrink();

class RowLeadAndTrailPlacer extends StatelessWidget {
  final Widget? leading, trailing, child;
  final IconData? leadIcon, trailIcon;
  final int maxLines;
  final double? textSize, iconSize, gapSize;
  final String text;
  final Color? textColor, iconColor, iconBoxColor;

  /// [limitDisability] affects the opacity of a disabled child
  final bool hideTrailing, makeTextSelectable, limitDisability;
  final bool? toggleExpand;
  final TextStyle? textStyle;
  final FontWeight? weight;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  final String? tooltip;
  const RowLeadAndTrailPlacer(
      {Key? key,
      this.leading,
      this.trailing,
      this.margin,
      this.leadIcon,
      this.trailIcon,
      this.textSize,
      this.iconSize,
      this.gapSize,
      this.text = "",
      this.textColor,
      this.iconColor,
      this.hideTrailing = false,
      this.limitDisability = false,
      this.iconBoxColor,
      this.textStyle,
      this.toggleExpand,
      this.weight,
      this.child,
      this.mainAxisAlignment,
      this.mainAxisSize,
      this.maxLines = 1,
      this.onPressed,
      this.tooltip,
      this.makeTextSelectable = false})
      : assert(leading != null && leadIcon == null ||
            leading == null && leadIcon != null ||
            leading == null && leadIcon == null),
        assert(trailing != null && trailIcon == null ||
            trailing == null && (trailIcon != null || trailIcon == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = textStyle ??
        defaultStyle(
            weight: weight ?? FontWeight.w600,
            size: textSize ?? 12,
            color: textColor ?? Theme.of(context).primaryColor);

    Widget wrapper({required Widget child}) {
      return SplashPressButtonWrapper(
        onTap: onPressed,
        highLight: Theme.of(context).highlightColor.withOpacity(.2),
        child: child,
      );
    }

    return Tooltip(
      message: tooltip ?? '',
      child: wrapper(
        child: Padding(
          padding: margin ?? padNone(),
          child: Row(
            mainAxisSize: mainAxisSize ?? MainAxisSize.min,
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              if (leading != null) leading!,
              if (leading == null && leadIcon != null)
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: iconBoxColor),
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    leadIcon,
                    size: iconSize ?? 16,
                    color: iconColor ?? Colors.white,
                  ),
                ),
              if (leading != null || leadIcon != null) LabGap(gapSize ?? 8),
              if (child == null)
                Flexible(
                  flex: 8,
                  child: !makeTextSelectable
                      ? text.textView(lines: maxLines, style: style)
                      : text.textSelectableView(lines: maxLines, style: style),
                ),
              if (child != null) child!,
              if (!hideTrailing) LabGap(gapSize ?? 8),
              if (trailing == null && !hideTrailing)
                Flexible(
                  flex: 2,
                  child: Icon(
                    trailIcon ??
                        (toggleExpand == true
                            ? Icons.expand_less
                            : Icons.expand_more),
                    color: iconColor ?? Theme.of(context).primaryColor,
                    size: 14,
                  ),
                ),
              if (trailing != null && !hideTrailing)
                Flexible(flex: 2, child: trailing!)
            ],
          ),
        ),
      ),
    );
  }
}


class TitleAndSubtitle extends StatelessWidget {
  final String title, subtitle;
  final String? superScript;
  final Widget? scriptChild;
  final EdgeInsetsGeometry? margin;
  final TextStyle? titleStyle, subtitleStyle;
  final Color? titleColor, subtitleColor, scriptColor;
  final TextAlign textAlign;
  final double? titleSize,
      subtitleSize,
      subTextHeight,
      subWordSpacing,
      subLetterSpacing,
      gap;
  final int? subMaxLine, titleMaxLines;
  final FontWeight? titleWeight, subWeight;
  final CrossAxisAlignment? alignment;
  const TitleAndSubtitle(
      {Key? key,
      required this.title,
      this.subtitle = '',
      this.margin,
      this.titleStyle,
      this.subtitleStyle,
      this.titleColor,
      this.subtitleColor,
      this.titleSize,
      this.subtitleSize,
      this.superScript,
      this.titleWeight,
      this.subWeight,
      this.alignment,
      this.subMaxLine,
      this.scriptColor,
      this.scriptChild,
      this.titleMaxLines,
      this.subTextHeight,
      this.subWordSpacing,
      this.subLetterSpacing,
      this.gap,
      this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
        children: [
          RichText(
              maxLines: titleMaxLines ?? 1,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign,
              text: TextSpan(
                  style: titleStyle ??
                      defaultStyle(
                        size: titleSize ?? getProportionateScreenHeight(18.8),
                        color: titleColor ?? Theme.of(context).primaryColor,
                        weight: titleWeight ?? FontWeight.bold,
                      ),
                  children: [
                    TextSpan(text: title),
                    WidgetSpan(
                      child: Transform.translate(
                        offset: const Offset(2, -4),
                        child: scriptChild ??
                            Text(superScript ?? '',
                                //superscript is usually smaller in size
                                textScaleFactor: 0.5,
                                style: defaultStyle(color: scriptColor)),
                      ),
                    )
                  ])),
          LabGap(gap ?? 8),
          if (subtitle != '')
            Flexible(
              child: Text(
                subtitle,
                maxLines: subMaxLine ?? 3,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textAlign: textAlign,
                style: subtitleStyle ??
                    defaultStyle(
                        size: subtitleSize ?? getProportionateScreenHeight(12.4),
                        textHeight: subTextHeight,
                        letterSpacing: subLetterSpacing,
                        wordSpacing: subWordSpacing,
                        color: subtitleColor ?? Colors.grey,
                        weight: subWeight),
              ),
            ),
        ],
      ),
    );
  }
}


class WidgetAppBar extends StatelessWidget implements PreferredSize {
  final double toolBarHeight;
  @override
  final Widget child;

  const WidgetAppBar(
      {Key? key, required this.toolBarHeight, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight);
}

class CustomDivider extends StatelessWidget {
  final double? height, width, radius;
  final Color? color;
  final EdgeInsets? margin;
  const CustomDivider({
    Key? key,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 40,
      height: height ?? 1,
      margin: margin,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(radius ?? 0)),
    );
  }
}
