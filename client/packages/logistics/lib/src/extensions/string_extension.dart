import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:logistics/logistics.dart';

extension CapExtension on String {
  String get shuffled => (characters.toList()..shuffle()).join();
  String get obscure => (characters.map((e) => "*").toList()).join();
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalize).join(" ");

  String get removeSpecialCharacters => replaceAll(RegExp('[^A-Za-z0-9]'), '');

  bool equalsIgnoreCase(String? string2) {
    return toLowerCase() == string2?.toLowerCase();
  }

  Widget textView(
          {double? size,
          FontWeight? weight,
          double? lineHeight,
          double? letterSpacing,
          int? lines,
          Color? color,
          TextAlign? textAlign,
          EdgeInsetsGeometry? padding,
          TextStyle? style}) =>
      Padding(
        padding: padding ?? padAll(pad: 0),
        child: Text(
          this,
          textAlign: textAlign,
          maxLines: lines,
          style: style ??
              defaultStyle(
                size: size ?? 12,
                letterSpacing: letterSpacing,
                textHeight: lineHeight,
                color: color,
                weight: weight ?? FontWeight.w500,
              ),
        ),
      );

  Widget highlightedText({
    TextAlign textAlign = TextAlign.justify,
    EdgeInsetsGeometry? padding,
    TextStyle? style,
    double? size,
    FontWeight? weight,
    double? lineHeight,
    double? letterSpacing,
    double? textHeight,
    double? wordSpacing,
    int? lines,
    bool matchCase = false,
    List<TextHighlightObject> highlighted = const [],
  }) {
    var defStyle = style ??
        defaultStyle(
            size: size,
            weight: weight,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textHeight: textHeight);

    Map<String, HighlightedWord> words = {
      for (var e in highlighted)
        e.text: HighlightedWord(
          onTap: e.onPressed,
          textStyle: e.style ??
              defStyle.copyWith(
                color: e.color,
                decoration: e.decoration,
                decorationColor: e.decorationColor,
              ),
        ),
    };

    return Padding(
      padding: padding ?? padNone(),
      child: TextHighlight(
        text: this,
        words: words,
        softWrap: true,
        textAlign: textAlign,
        textStyle: defStyle,
        maxLines: lines,
        matchCase: matchCase,
      ),
    );
  }

  Widget textSelectableView(
          {double? size,
          FontWeight? weight,
          EdgeInsetsGeometry? padding,
          double? lineHeight,
          int? lines,
          double? letterSpacing,
          Color? color,
          TextAlign? textAlign,
          TextStyle? style}) =>
      Padding(
        padding: padding ?? padAll(pad: 0),
        child: SelectableText(
          this,
          textAlign: textAlign,
          maxLines: lines,
          style: style ??
              defaultStyle(
                size: size ?? 12,
                letterSpacing: letterSpacing,
                textHeight: lineHeight,
                color: color,
                weight: FontWeight.w500,
              ),
        ),
      );
}
