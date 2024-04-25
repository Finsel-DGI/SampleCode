import 'package:client/src/modules/components/bars/header.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:labs_web/labs_web.dart';

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
        return [
          const SliverToBoxAdapter(
            child: Header(),
          )
        ];
      },
      body: widget.child,
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
