import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VisualView extends StatelessWidget {
  const VisualView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title = const Text(
      'SOME\nVISUAL\nEFFECTS\n\n  on\n\nRAINBOW\nTEXT',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 64,
        color: Color(0xFF666870),
        height: 0.9,
        letterSpacing: -4,
      ),
    );

    // add a rainbow gradient:
    // I'm lazy so I'll just apply a ShimmerEffect
    // and use a ValueAdapter to pause it at 0.4
    title = title.animate(adapter: ValueAdapter(0.4)).shimmer(
      duration: 2.seconds,
      size: 0.5,
      colors: [
        const Color(0xFFFFFF00),
        const Color(0xFF00FF00),
        const Color(0xFF00FFFF),
        const Color(0xFF0033FF),
        const Color(0xFFFF00FF),
        const Color(0xFFFF0000),
        const Color(0xFFFFFF00),
      ],
    );

    // sequence some visual effects
    title = title
        .animate(onInit: (controller) => controller.repeat(reverse: true))
        .saturate(delay: 1.seconds, duration: 2.seconds)
        .then() // set delay to when the previous effect ends.
        .tint(color: const Color(0xFF80DDFF))
        .then()
        .blur(end: 24)
        .fadeOut();

    return Padding(padding: const EdgeInsets.all(16), child: title);
  }
}
