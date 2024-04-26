import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/modules/components/custom/pasby_button.dart';
import 'package:client/src/modules/enums/default.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/views/landing/components/source_code.dart';
import 'package:flutter/material.dart';
import 'package:labs/labs.dart';
import 'package:labs_web/labs_web.dart';
import 'package:sizer/sizer.dart';

class StartDemo extends StatelessWidget {
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
        PasbyButton(
          action: PasbyAction.login,
          callback: () async {
            // await delayed();
            
            /// todo nav to identification shell and in shell determine if you use qr code or same device
          },
          margin: EdgeInsets.only(top: 4.8.h),
        ),
        // PasbyButton(
        //   action: PasbyAction.sign,
        //   callback: () async {},
        //   margin: EdgeInsets.only(top: 4.8.h),
        // ),
        ViewSourceCode(
          margin: EdgeInsets.only(top: 4.8.h),
        ),
      ],
    );
  }
}
