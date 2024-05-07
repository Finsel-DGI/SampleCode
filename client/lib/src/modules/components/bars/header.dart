import 'package:anydrawer/anydrawer.dart';
import 'package:client/gen/assets.gen.dart';
import 'package:client/gen/fonts.gen.dart';
import 'package:client/src/blocs/routing/names.dart';
import 'package:client/src/blocs/session/mixin/app_event.dart';
import 'package:client/src/blocs/session/mixin/shared_state.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';
import 'package:sizer/sizer.dart';

class Header extends HookConsumerWidget with AppSharedState, AppEvent {
  Header({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var drawer = useState(AnyDrawerController());

    bool onLanding(
      String location,
    ) {
      var path = location.split('?');
      return location.startsWith(RouteNames.landingRoute.route) ||
          path[0].endsWith(RouteNames.landingRoute.name);
    }

    return Padding(
      padding: padAsymmetric(
        horiz: Responsive.isMobile(context) ? 4.w : 2.w,
        vert: 2.4.h,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RowLeadAndTrailPlacer(
            leading: SplashPressButtonWrapper(
              onTap: () {
                context.go(RouteNames.landingRoute.route);
              },
              imageSplash: true,
              borderRadius: BorderRadius.circular(80),
              child: Assets.svg.pasby.svg(
                height: getProportionateScreenHeight(50),
              ),
            ),
            hideTrailing: true,
            gapSize: 2.h,
            text: "Demo",
            textStyle: appTextStyle(
              size: getProportionateScreenHeight(18),
              color: context.theme.primaryColor,
              family: FontFamily.libre,
              weight: FontWeight.w400,
            ),
          ),
          RowLeadAndTrailPlacer(
            hideTrailing: true,
            child: ConsoleButton(
              arg: context
                  .buttonArg(
                      child: Icon(
                        Icons.settings,
                        size: getProportionateScreenHeight(28),
                        color: Colors.white,
                      ),
                      callback: () async {
                        if (onLanding(
                            GoRouterState.of(context).matchedLocation)) {
                          toggleSettings(context, ref, drawer.value);
                        }
                      })
                  .copyWith(
                    bckColor: context.theme.primaryColor,
                    circular: true,
                    margin: padNone(),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
