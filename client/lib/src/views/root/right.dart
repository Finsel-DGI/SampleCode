import 'package:client/src/views/root/component/cta.dart';
import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

class ScreenRight extends StatelessWidget {
  const ScreenRight({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        width: size.maxWidth,
        height: size.maxHeight,
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      end: FractionalOffset.topCenter,
                      begin: FractionalOffset.bottomCenter,
                      colors: [
                        context.colorScheme.tertiary
                            .darker(20)
                            .withOpacity(0.0),
                        context.colorScheme.tertiary
                      ],
                      stops: const [
                        1.0,
                        0.0
                      ])),
            ),
            Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [darkBackground.withOpacity(0.0), darkBackground],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: CTAView()
            ),
          ],
        ),
      );
    });
  }
}