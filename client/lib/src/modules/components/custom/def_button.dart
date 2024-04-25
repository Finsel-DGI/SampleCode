import 'package:flutter/material.dart';
import 'package:labs/labs.dart';
import 'package:labs_web/labs_web.dart';

class ConsoleButton extends StatelessWidget {
  final NativeButtonArguments arg;
  const ConsoleButton({super.key, required this.arg, });

  @override
  Widget build(BuildContext context) {
    return WebButton(
      args: arg,
    );
  }
}