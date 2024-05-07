import 'package:client/gen/assets.gen.dart';
import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/modules/components/custom/pasby_button.dart';
import 'package:client/src/modules/enums/default.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/views/flow/bloc/flow_event.dart';
import 'package:client/src/views/landing/component/source_code.dart';
import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class StartDemo extends StatelessWidget with FlowEvents {
  const StartDemo({super.key});

  @override
  Widget build(BuildContext context) {
    var style = appTextStyle(
      color: context.theme.primaryColor,
      size: getProportionateScreenHeight(24.6),
      weight: FontWeight.w800,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Responsive.isMobile(context)) ...[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 400,
            margin: padAsymmetric(
              horiz: 20,
              vert: 2.8.h,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Assets.rive.offerPasby.rive(
              fit: BoxFit.cover,
            ),
          )
        ],
        TitleAndSubtitle(
          margin: padNone(),
          title: context.localizedText!.home("title"),
          subtitle: context.localizedText!.home("sub"),
          titleStyle: style,
          titleMaxLines: 6,
          subMaxLine: 12,
          gap: 18,
          subtitleStyle: style.copyWith(
            fontSize: getProportionateScreenHeight(14.2),
            wordSpacing: 1.4,
            fontFamily: FontFamily.libre,
            letterSpacing: .6,
            fontWeight: FontWeight.w400,
          ),
        ),
        PasbyButton<void>(
          action: PasbyAction.login,
          callback: () async {
            matchAuthFlow(context);
          },
          margin: EdgeInsets.only(top: 4.8.h),
        ),
        PasbyButton<void>(
          action: PasbyAction.confirm,
          callback: () async {
            matchConfirmationFlow(context);
          },
          margin: EdgeInsets.only(top: 4.8.h),
        ),
        ViewSourceCode(
          margin: EdgeInsets.only(top: 4.8.h),
        ),
      ],
    );
  }
}
