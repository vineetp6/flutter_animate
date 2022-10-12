import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'tester_extensions.dart';

void main() {
  testWidgets('curved tween w/ 1000s duration', (tester) async {
    const curve = Curves.easeOut;
    final animation = const FlutterLogo().animate().fade(duration: 1000.ms, curve: curve);
    // wait 500ms and check middle pos
    await tester.pumpAnimation(animation, initialDelay: 500.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, curve.transform(.5), 'opacity');
    // wait another 50ms and check end pos
    await tester.pump(500.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, curve.transform(1), 'opacity');
  });

  testWidgets('linear tween w/ 500ms duration', (tester) async {
    final animation = const FlutterLogo().animate().fade(duration: 500.ms);
    await tester.pumpAnimation(animation, initialDelay: 250.ms);
    // check halfway
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, .5, 'opacity');
    // check end
    await tester.pump(250.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, 1, 'opacity');
  });

  testWidgets('delayed tween', (tester) async {
    final animation = const FlutterLogo().animate().fade(delay: 1.seconds, duration: 1.seconds);

    // Wait and expect it hasn't started yet
    await tester.pumpAnimation(animation, initialDelay: 500.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, 0, 'opacity');

    // Wait and expect it is now half-way through
    await tester.pump(1000.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, .5, 'opacity');
  });

  testWidgets('delayed animate', (tester) async {
    // use a 1 second delay and 1 second duration
    final animation = const FlutterLogo().animate(delay: 1.seconds).fade(duration: 1.seconds);

    // Wait 500ms expect it hasn't started yet
    await tester.pumpAnimation(animation, initialDelay: 500.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, 0, 'opacity');

    // Wait 1s expect it is now half-way through (two pumps are required to get the delay to fire)
    await tester.pump(500.ms);
    await tester.pump(500.ms);
    tester.expectWidgetValue<FadeTransition>((w) => w.opacity.value, .5, 'opacity');
  });
}
