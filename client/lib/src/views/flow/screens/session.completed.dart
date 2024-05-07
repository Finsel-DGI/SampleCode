import 'package:client/gen/assets.gen.dart';
import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/modules/models/misc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logistics/logistics.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:sizer/sizer.dart';

class FlowSucceeded extends StatelessWidget {
  const FlowSucceeded({super.key, required this.method, required this.flow});

  final String method;
  final FlowSuccess flow;

  @override
  Widget build(BuildContext context) {
    const pear = Color(0xFFCBE454);

    return Container(
      width: 600,
      constraints: const BoxConstraints(minHeight: 540),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: pear.withAlpha(60),
      ),
      margin: padAsymmetric(),
      padding: padAsymmetric(horiz: 30, vert: 2.4.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.svg.pasby.svg(
            color: pear.withAlpha(60),
            height: getProportionateScreenHeight(140.4),
          ),
          "Success!".textView(
            textAlign: TextAlign.center,
            padding: EdgeInsets.only(
              bottom: 2.8.h,
              top: 2.8.h,
            ),
            style: appTextStyle(
              family: FontFamily.libre,
              variation: 780,
              size: getProportionateScreenHeight(30.4),
              color: context.colorScheme.tertiary,
            ),
          ),
          ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _Content(
                  header: context.localizedText!.success('name'),
                  content: flow.name,
                ),
                _Content(
                  header: context.localizedText!.success('nin'),
                  content:
                      "${flow.user.substring(0, 4)}${flow.user.substring(4, 11).obscure}",
                ),
                context.localizedText!.success('signed').textView(
                      padding: EdgeInsets.only(bottom: 2.4.h),
                      style: appTextStyle(
                        color: context.colorScheme.tertiary,
                        size: getProportionateScreenHeight(14.6),
                        variation: 400,
                      ),
                    ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: MarkdownGenerator().buildWidgets(flow.content),
                )
              ],
            )
          ],
          ConsoleButton(
              arg: context
                  .buttonArg(
                    text: context.localizedText!.again,
                    textSize: getProportionateScreenHeight(15),
                    textColor: Colors.white,
                    width: 220,
                    height: 58,
                    callback: () async {
                      context.goNamed(RouteNames.landingRoute.name);
                    },
                  )
                  .copyWith(
                    bckColor: Colors.black,
                    margin: padAsymmetric(
                      vert: 4.4.h,
                    ),
                    radius: 6,
                  )),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.header, required this.content});

  final String header, content;

  @override
  Widget build(BuildContext context) {
    var style = appTextStyle(
      color: context.colorScheme.tertiary,
      size: getProportionateScreenHeight(24.6),
      variation: 400,
    );
    return RowLeadAndTrailPlacer(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      hideTrailing: true,
      margin: EdgeInsets.only(bottom: 2.6.h),
      leading: header.textView(
        style: style.copyWith(
            fontSize: getProportionateScreenHeight(14.2),
            fontWeight: FontWeight.w400),
      ),
      child: content.textView(
        style: style.copyWith(
          fontSize: getProportionateScreenHeight(14.2),
        ),
      ),
    );
  }
}
