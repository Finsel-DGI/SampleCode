import 'package:labs/labs.dart';

class RouteNames {
  static MenuArgs landingRoute = MenuArgs(route: "/", name: "landing");
  static MenuArgs otherDevice = MenuArgs(route: "scan-qr", name: "other-device");
  static MenuArgs sameDevice = MenuArgs(route: "auto-start", name: "same-device");
  static MenuArgs auth = MenuArgs(route: "/identification", name: "identification");
  static MenuArgs signing = MenuArgs(route: "/signing", name: "signing");
  static MenuArgs success = MenuArgs(route: "success", name: "success");
}
