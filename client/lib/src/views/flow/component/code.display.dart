import 'dart:async';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

class SeedCodeDisplay extends StatefulWidget {
  final List<String> seeds;
  final bool pauseChanges;

  final EdgeInsets? margin;

  const SeedCodeDisplay(
      {super.key, required this.seeds, this.pauseChanges = false, this.margin});

  @override
  State<SeedCodeDisplay> createState() => _SeedCodeDisplayState();
}

class _SeedCodeDisplayState extends State<SeedCodeDisplay> {
  late Timer timer;
  String seed = "";

  @override
  void initState() {
    if (widget.seeds.length == 1) {
      seed = widget.seeds[0];
    } else {
      seed = widget.seeds[0];
      timer = Timer.periodic(
          const Duration(milliseconds: 1200), (timer) => shuffleSeed());
    }
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void shuffleSeed() {
    if (widget.pauseChanges) {
      timer.cancel();
      return;
    }
    setState(() {
      seed = widget.seeds[randomNumberBtwRange(widget.seeds.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    var radius = 8.0;
    Widget wrapper({required Widget child}) {
      if (widget.pauseChanges) {
        return Blur(
          blur: widget.pauseChanges ? 2.8 : 0,
          borderRadius: BorderRadius.circular(radius),
          child: child,
        );
      } else {
        return child;
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      alignment: Alignment.center,
      margin: widget.margin,
      padding: padAll(pad: 14),
      child: wrapper(
        child: QrContainer(
          data: seed,
          size: getProportionateScreenHeight(240),
          background: Colors.transparent,
          radius: 2,
          color: Colors.black,
        ),
      ),
    );
  }
}
