import 'package:client/gen/assets.gen.dart';
import 'package:client/src/modules/enums/default.dart';

extension Href on PasbyAction {
  SvgGenImage get button {
    switch (this) {
      case PasbyAction.confirm:
        return Assets.svg.confirm;
      case PasbyAction.sign:
        return Assets.svg.sign;
      default:
        return Assets.svg.login;
    }
  }
}
