import 'package:client/gen/assets.gen.dart';
import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:labs/labs.dart';
import 'package:labs_web/labs_web.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

class CTAView extends StatefulWidget {
  const CTAView({super.key});

  @override
  State<CTAView> createState() => _CTAViewState();
}

class _CTAViewState extends State<CTAView> {
  Artboard? _artboard;

  bool get isPlaying => _artboard?.isPlaying ?? false;

  /// Toggles between play and pause on the artboard
  void _togglePlay() {
    if (isPlaying) {
      _artboard?.pause();
    } else {
      _artboard?.play();
    }
    // We call set state to update the Play/Pause Icon. This isn't needed
    // to update Rive.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: 400,
          margin: padAsymmetric(horiz: 20),
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Assets.rive.offerPasby.rive(
            fit: BoxFit.cover,
            onInit: (v) {
              setState(() {
                _artboard = v;
              });
            },
          ),
        ),
        ConsoleButton(
          arg: context
              .buttonArg(
                child: RowLeadAndTrailPlacer(
                  leadIcon: isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_arrow_rounded,
                  iconColor: context.theme.primaryColor,
                  iconSize: getProportionateScreenHeight(18),
                  text: context.localizedText!
                      .player(isPlaying ? "pause" : "play"),
                  textStyle: appTextStyle(
                    size: getProportionateScreenHeight(11.2),
                    color: context.theme.primaryColor,
                  ),
                  hideTrailing: true,
                ),
                callback: () async {
                  _togglePlay();
                },
              )
              .copyWith(
                padding: padAll(pad: 8),
                width: 120,
                margin: EdgeInsets.only(top: 1.2.h, bottom: 2.2.h),
                height: 40,
                radius: 40,
              ),
        ),
        TitleAndSubtitle(
          title: context.localizedText!.cta("title"),
          // subtitle: context.localizedText!.cta("sub"),
          margin: padAsymmetric(horiz: 12, vert: 1.4.h),
          titleMaxLines: 2,
          titleStyle: appTextStyle(
            size: getProportionateScreenHeight(20.4),
            color: Colors.white,
            weight: FontWeight.w800,
          ),
          alignment: CrossAxisAlignment.center,
          textAlign: TextAlign.center,
          subtitleStyle: appTextStyle(
            letterSpacing: .8,
            size: getProportionateScreenHeight(12.4),
            color: Colors.white,
            family: FontFamily.libre,
            variation: 200,
          ),
        ),
        ConsoleButton(
          arg: context
              .buttonArg(
                text: context.localizedText!.cta("action"),
                callback: () async {
                  await UrlService().launchURL(
                      'https://www.pasby.africa/integrate-pasby',
                      browser: true);
                },
              )
              .copyWith(
                width: 280,
                bckColor: Colors.transparent,
                margin: EdgeInsets.only(bottom: 2.2.h, top: 2.2.h),
                height: 54,
              ),
        ),
      ],
    );
  }
}
