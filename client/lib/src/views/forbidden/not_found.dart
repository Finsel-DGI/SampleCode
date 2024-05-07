import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

class ForbiddenRoute extends StatelessWidget {
  const ForbiddenRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var style = appTextStyle(
        variation: 440,
        size: getProportionateScreenHeight(22),
        color: Colors.white
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: RowLeadAndTrailPlacer(
          leading: "404".textView(
            style: style
          ),
          gapSize: 18,
          trailing: context.localizedText!.lostPage.textView(
            style: style.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: getProportionateScreenHeight(14)
            )
          ),
          child: CustomDivider(
            height: getProportionateScreenHeight(42),
            width: 1,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
