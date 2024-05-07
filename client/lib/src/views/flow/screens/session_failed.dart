import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class FlowFailure extends StatelessWidget {
  const FlowFailure(
      {super.key, required this.method, required this.technical, this.message});

  final String method;
  final String? message;
  final bool technical;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      constraints: const BoxConstraints(minHeight: 540),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: tomato.withAlpha(60),
      ),
      margin: padAsymmetric(),
      padding: padAsymmetric(horiz: 30, vert: 2.4.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.grey,
            size: getProportionateScreenHeight(140.4),
          ),
          context.localizedText!.pasby(method).textView(
                textAlign: TextAlign.center,
                padding: EdgeInsets.only(
                  bottom: 1.8.h,
                  top: 2.8.h,
                ),
                style: appTextStyle(
                  family: FontFamily.libre,
                  variation: 780,
                  size: getProportionateScreenHeight(30.4),
                  color: context.colorScheme.tertiary,
                ),
              ),
          (message ?? context.localizedText!.errors('flow')).textSelectableView(
            textAlign: TextAlign.center,
            padding: EdgeInsets.only(
              top: 2.8.h,
              left: 14,
              right: 14,
            ),
            style: appTextStyle(
              family: FontFamily.libre,
              size: getProportionateScreenHeight(16.4),
              variation: 400,
              color: context.colorScheme.tertiary,
            ),
          ),
          ConsoleButton(
              arg: context
                  .buttonArg(
                    text: context.localizedText!.retry,
                    textSize: getProportionateScreenHeight(15),
                    textColor: Colors.white,
                    width: 180,
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
