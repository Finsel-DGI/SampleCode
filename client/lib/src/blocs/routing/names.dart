import 'package:logistics/logistics.dart';

class RouteNames {
  static MenuArgs landingRoute = MenuArgs(route: "/", name: "landing");
  static MenuArgs flow = MenuArgs(route: "/flow/:method", name: "pasby-flow");
  static MenuArgs flowFailed = MenuArgs(route: "/flow/:method/failure", name: "failed-flow");
  static MenuArgs confirmation = MenuArgs(route: "confirm", name: "confirm-action");
  static MenuArgs secureStart = MenuArgs(route: "scan-qr", name: "secure-start");
  static MenuArgs autoStart = MenuArgs(route: "auto-start", name: "auto-start");
  static MenuArgs success = MenuArgs(route: "/flow/:method/success", name: "flow-success");
}
