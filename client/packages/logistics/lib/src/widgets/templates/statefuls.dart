import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';

abstract class BaseStatefulTemplate extends ConsumerStatefulWidget {
  const BaseStatefulTemplate({Key? key}) : super(key: key);
}

abstract class BaseScreenTemplateState<T extends BaseStatefulTemplate>
    extends ConsumerState<T> {
  PreferredSizeWidget? appBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget? endDrawer() {
    return null;
  }

  GlobalKey<ScaffoldState>? _key;
  bool _isHome = false, _stretch = false, _zoom = false;
  Color? _bck;
  int _barDarkening = 20;
  DrawerCallback? _drawerUpdated;
  DrawerCallback? _endDrawerUpdated;
  FloatingActionButtonLocation _floatLocation =
      FloatingActionButtonLocation.endFloat;

  Widget? floatingActionButton() {
    return null;
  }

  void onDrawerUpdated(DrawerCallback? value) {
    _drawerUpdated = value;
  }

  void onEndDrawerUpdated(DrawerCallback? value) {
    _endDrawerUpdated = value;
  }

  void floatLocation(FloatingActionButtonLocation value) {
    _floatLocation = value;
  }

  ActionCallback<bool> willPopScope() {
    return () async => true;
  }

  Widget? bottomBar() {
    return null;
  }

  void toggleBckColor(Color value) {
    _bck = value;
  }

  void navBarDarkenDegree(int value) {
    setState(() {
      _barDarkening = value;
    });
  }

  void setScaffoldKey(GlobalKey<ScaffoldState>? value) {
    _key = value;
  }

  void isHomeScreen(bool isHome) {
    _isHome = isHome;
  }

  void stretchBody(bool value) {
    _stretch = value;
  }

  void toggleZoom(bool value) {
    setState(() {
      _zoom = value;
    });
  }
}

mixin BaseScreen<T extends BaseStatefulTemplate> on BaseScreenTemplateState<T> {
  Widget body();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope(),
      child: Scaffold(
        drawer: drawer(),
        onDrawerChanged: _drawerUpdated,
        onEndDrawerChanged: _endDrawerUpdated,
        endDrawer: endDrawer(),
        key: _key,
        floatingActionButtonLocation: _floatLocation,
        extendBodyBehindAppBar: _stretch,
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: EdgeInsets.all(_zoom ? 8.0 : 0.0),
          child: body(),
        ),
        backgroundColor: _bck ??
            (_isHome
                ? Theme.of(context).colorScheme.background.darker(_barDarkening)
                : Theme.of(context).scaffoldBackgroundColor),
        appBar: appBar(),
        floatingActionButton: floatingActionButton(),
        bottomNavigationBar: bottomBar(),
      ),
    );
  }
}
