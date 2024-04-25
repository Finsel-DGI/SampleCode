import 'package:flutter/material.dart';
import 'package:labs/labs.dart';

class LandingSelf extends StatelessWidget {
  const LandingSelf({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Responsive(
        mobile: emptyView,
        desktop: emptyView,
      ),
    );
  }
}
