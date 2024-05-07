import 'package:client/gen/assets.gen.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

class ViewSourceCode extends StatelessWidget {
  const ViewSourceCode({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return ConsoleButton(
      arg: context
          .buttonArg(
            child: RowLeadAndTrailPlacer(
              text: context.localizedText!.repo,
              trailing: Assets.svg.github.svg(
                height: getProportionateScreenHeight(26),
              ),
              textStyle: appTextStyle(
                size: getProportionateScreenHeight(14.6),
                color: context.theme.primaryColor,
                weight: FontWeight.w600,
              ),
            ),
            callback: () async {
              await UrlService.launchURL(
                "https://github.com/Finsel-DGI/SampleCode",
                browser: true
              );
            },
            width: 260,
          )
          .copyWith(
            margin: margin,
          ),
    );
  }
}
