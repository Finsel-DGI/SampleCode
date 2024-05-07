import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension MaterialStateHelpers on Iterable<MaterialState> {
  bool get isHovered => contains(MaterialState.hovered);
  bool get isFocused => contains(MaterialState.focused);
  bool get isPressed => contains(MaterialState.pressed);
  bool get isDragged => contains(MaterialState.dragged);
  bool get isSelected => contains(MaterialState.selected);
  bool get isScrolledUnder => contains(MaterialState.scrolledUnder);
  bool get isDisabled => contains(MaterialState.disabled);
  bool get isError => contains(MaterialState.error);
}

extension BSEnumExtension on Color {
  Color darker(int intensity) => _darken(this, intensity);
  Color lighter(int intensity) => _lighten(this, intensity);
}

extension IterableExtensions on Iterable {
  bool containsAny(Iterable<Object?> other) => other.any((e) => contains(e));
}

extension Vtv on NativeButtonArguments {
  /// Creates a copy of this NativeButtonArguments but with the given fields replaced
  /// with the new values.
  NativeButtonArguments copyWith({
    String? text,
    VoidCallback? onLongPress,
    VoidCallback? firstCallback,
    ActionCallback? onTap,
    double? width,
    double? height,
    double? textSize,
    double? size,
    double? radius,
    double? borderWidth,
    Color? bckColor,
    Color? textColor,
    Color? borderColor,
    Color? inactiveColor,
    bool? busy,
    bool? inactive,
    bool? bouncing,
    Widget? child,
    Widget? loader,
    ValueChanged<bool>? onHover,
    TextStyle? style,
    FontWeight? textWeight,
    bool? circular,
    EdgeInsets? margin,
    EdgeInsets? padding,
    String? tooltip,
    Alignment? alignment,
  }) {
    return NativeButtonArguments(
      onTap: onTap ?? this.onTap,
      firstCallback: firstCallback ?? this.firstCallback,
      text: text ?? this.text,
      width: width ?? this.width,
      height: height ?? this.height,
      radius: radius ?? this.radius,
      inactive: inactive ?? this.inactive,
      textColor: textColor ?? this.textColor,
      bckColor: bckColor ?? this.bckColor,
      textSize: textSize ?? this.textSize,
      borderColor: borderColor ?? this.borderColor,
      child: child ?? this.child,
      alignment: alignment ?? this.alignment,
      bouncing: bouncing ?? this.bouncing,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      textWeight: textWeight ?? this.textWeight,
      tooltip: tooltip ?? this.tooltip,
      onHover: onHover ?? this.onHover,
      onLongPress: onLongPress ?? this.onLongPress,
      padding: padding ?? this.padding,
      size: size ?? this.size,
      style: style ?? this.style,
      loader: loader ?? this.loader,
      circular: circular ?? this.circular,
      borderWidth: borderWidth ?? this.borderWidth,
      busy: busy ?? this.busy,
      margin: margin ?? this.margin,
    );
  }
}

/// Darken a color by [percent] amount (100 = black)
// ........................................................
Color _darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

/// Lighten a color by [percent] amount (100 = white)
// ........................................................
Color _lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}
