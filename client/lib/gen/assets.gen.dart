/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class $AssetsI18nGen {
  const $AssetsI18nGen();

  /// File path: assets/i18n/en.json
  String get en => 'assets/i18n/en.json';

  /// List of all assets
  List<String> get values => [en];
}

class $AssetsRiveGen {
  const $AssetsRiveGen();

  /// File path: assets/rive/offer_pasby.riv
  RiveGenImage get offerPasby =>
      const RiveGenImage('assets/rive/offer_pasby.riv');

  /// List of all assets
  List<RiveGenImage> get values => [offerPasby];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/github.svg
  SvgGenImage get github => const SvgGenImage('assets/svg/github.svg');

  /// File path: assets/svg/login.svg
  SvgGenImage get login => const SvgGenImage('assets/svg/login.svg');

  /// File path: assets/svg/pasby.svg
  SvgGenImage get pasby => const SvgGenImage('assets/svg/pasby.svg');

  /// File path: assets/svg/sign.svg
  SvgGenImage get sign => const SvgGenImage('assets/svg/sign.svg');

  /// File path: assets/svg/use-pasby.svg
  SvgGenImage get usePasby => const SvgGenImage('assets/svg/use-pasby.svg');

  /// List of all assets
  List<SvgGenImage> get values => [github, login, pasby, sign, usePasby];
}

class Assets {
  Assets._();

  static const $AssetsI18nGen i18n = $AssetsI18nGen();
  static const $AssetsRiveGen rive = $AssetsRiveGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class RiveGenImage {
  const RiveGenImage(this._assetName);

  final String _assetName;

  RiveAnimation rive({
    String? artboard,
    List<String> animations = const [],
    List<String> stateMachines = const [],
    BoxFit? fit,
    Alignment? alignment,
    Widget? placeHolder,
    bool antialiasing = true,
    List<RiveAnimationController> controllers = const [],
    OnInitCallback? onInit,
  }) {
    return RiveAnimation.asset(
      _assetName,
      artboard: artboard,
      animations: animations,
      stateMachines: stateMachines,
      fit: fit,
      alignment: alignment,
      placeHolder: placeHolder,
      antialiasing: antialiasing,
      controllers: controllers,
      onInit: onInit,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
