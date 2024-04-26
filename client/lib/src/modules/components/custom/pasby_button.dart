import 'package:client/gen/assets.gen.dart';
import 'package:client/src/modules/components/custom/def_button.dart';
import 'package:client/src/modules/enums/default.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:labs/labs.dart';

class PasbyButton<T> extends HookWidget {
  const PasbyButton({
    super.key,
    required this.action,
    this.inactive = false,
    required this.callback,
    this.margin,
  });

  final PasbyAction action;
  final Future<T> Function() callback;
  final EdgeInsets? margin;
  final bool inactive;

  @override
  Widget build(BuildContext context) {
    var asset = action == PasbyAction.sign ? Assets.svg.sign : Assets.svg.login;

    var busy = useState(false);

    return ConsoleButton(
      arg: context
          .buttonArg(
            width: 252,
            height: 56,
            child: GreyScale(grey: inactive, child: asset.svg()),
            callback: () async {
              busy.value = true;
              await callback();
              busy.value = false;
            },
          )
          .copyWith(
            inactive: inactive,
            busy: busy.value,
            padding: padNone(),
            margin: margin,
          ),
    );
  }
}
