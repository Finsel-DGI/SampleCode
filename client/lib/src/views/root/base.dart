import 'package:client/src/modules/components/bars/header.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labs/labs.dart';
import 'package:labs_web/labs_web.dart';
import 'package:sizer/sizer.dart';

import 'right.dart';

class RootTemplate extends StatefulDefaultWrap {
  final Widget child;
  const RootTemplate({super.key, required this.child});

  @override
  ConsumerState<RootTemplate> createState() => _RootTemplateState();
}

class _RootTemplateState extends StatefulDefaultWrapState<RootTemplate>
    with DefBaseScreen {
  @override
  Widget body() {
    return NestedScrollView(
      headerSliverBuilder: (context, scroll) {
        return [];
      },
      body: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 8,
              child: Scaffold(
                appBar: const WidgetAppBar(toolBarHeight: 100, child: Header()),
                body: ListView(
                  padding: padAsymmetric(horiz: 4.w, vert: 4.8.h),
                  children: [
                    widget.child,
                  ],
                ),
              ),
            ),
            if (Responsive.isDesktop(context)) ...[
              const Flexible(
                flex: 6,
                child: ScreenRight(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  String pageTitle() {
    return context.localizedText!.appTitle;
  }

  // @override
  // Widget? bottomBar() {
  //   return const Footer();
  // }
}
