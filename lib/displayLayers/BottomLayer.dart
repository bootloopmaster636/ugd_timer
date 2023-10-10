import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class BottomLayer extends ConsumerWidget {
  const BottomLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayStateWatcher = ref.watch(displayStateProvider);

    return Animate(
      effects: const [
        SlideEffect(
            duration: Duration(milliseconds: 450),
            curve: Curves.easeInOutCubic,
            begin: Offset(0.0, 0.0),
            end: Offset(0.04, 0.0)
        ),
        FadeEffect(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
            begin: 1.0,
            end: 0.8
        ),
      ],
      target: (displayStateWatcher.settingsExpanded == true) ? 1 : 0,
      child: Stack(alignment: Alignment.center,
          children: [
            Lottie.asset(
              'assets/lottie_pattern_bg.json',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.96),
                Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.96),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
