import 'package:flutter/material.dart';

class GreyScale extends StatelessWidget {
  final Widget child;
  final bool grey;
  const GreyScale({Key? key, required this.child, required this.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!grey) return child;
    return ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]),
        child: child);
  }
}
