import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

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