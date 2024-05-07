import 'package:flutter/material.dart';
import 'package:logistics/src/services/browser.dart';
import 'statefuls.dart';

abstract class StatefulDefaultWrap extends BaseStatefulTemplate {
  const StatefulDefaultWrap({Key? key}) : super(key: key);
}

abstract class StatefulDefaultWrapState<T extends StatefulDefaultWrap>
    extends BaseScreenTemplateState<T> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String pageTitle();

  @override
  PreferredSizeWidget? appBar();
  @override
  Widget? drawer() {
    return null;
  }
}

mixin DefBaseScreen<T extends StatefulDefaultWrap>
    on StatefulDefaultWrapState<T> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) =>
        BrowserSettingsService().changeAppName(pageTitle(), Colors.white));
  }

  Widget body();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: drawer(),
      floatingActionButton: floatingActionButton(),
      bottomNavigationBar: bottomBar(),
    );
  }
}
