import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

  Future<dynamic> determineNavMethod(String routeName, {Object? argument, bool replace = false}) {
    if(replace){
      return navigateAndReplaceTo(routeName, argument: argument);
    }else{
      return navigateTo(routeName, argument: argument);
    }
  }

  Future<dynamic> navigateTo(String routeName, {Object? argument}) {
    return navigatorKey.currentContext!.pushNamed(routeName, extra: argument);
  }

  void goTo(String routeName, {Object? argument, Map<String, dynamic>? params}) {
    navigatorKey.currentContext!
        .goNamed(routeName, extra: argument,queryParameters: params ?? {});
  }

  Future<dynamic> navigateAndReplaceTo(String routeName, {Object? argument}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: argument);
  }



  bool canGoBack() {
    return navigatorKey.currentState!.canPop();
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}