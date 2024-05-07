import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LabGap extends StatelessWidget {
  final double mainAxisExtent;
  final double? crossAxisExtent;
  final Color? color;
  const LabGap(this.mainAxisExtent, {Key? key,
   this.crossAxisExtent, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Gap(mainAxisExtent, crossAxisExtent: crossAxisExtent, color: color,);
  }
}

class LabSliverGap extends StatelessWidget {
  final double mainAxisExtent;
  final Color? color;
  const LabSliverGap(this.mainAxisExtent, {Key? key,
  this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGap(mainAxisExtent, color: color,);
  }
}
