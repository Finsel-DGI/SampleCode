import 'package:flutter/material.dart';

TextStyle defaultStyle(
    {double? size,
    double? textHeight,
    Color? color,
    double? wordSpacing,
    double? letterSpacing,
    FontWeight? weight,
    String? family,
    String? package,
    TextDecoration? decoration}) {
  return TextStyle(
    fontFamily: family ?? 'Libre',
    package: package ?? (family == null ? 'logistics' : null),
    fontSize: size ?? 12,
    fontWeight: weight,
    color: color,
    decoration: decoration,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    height: textHeight,
  );
}

TextStyle appTextStyle(
    {double? size,
    double? textHeight,
    Color? color,
    double? wordSpacing,
    double? letterSpacing,
    String? family,
    FontWeight? weight,
    double? variation,
    TextDecoration? decoration}) {
  return defaultStyle(
          size: size,
          textHeight: textHeight,
          color: color,
          weight: weight ?? FontWeight.w400,
          family: family ?? 'Libre',
          decoration: decoration,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing)
      .copyWith(
    fontVariations:
        variation == null ? null : [FontVariation('wght', variation)],
  );
}
