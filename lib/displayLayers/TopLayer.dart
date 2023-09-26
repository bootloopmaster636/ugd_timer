import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_timer/main.dart';

class TopLayer extends ConsumerWidget {
  const TopLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayStateWatcher = ref.watch(displayStateProvider);
    return Animate(
      effects: const [
        SlideEffect(duration: Duration(milliseconds: 450), curve: Curves.easeOutCubic, begin: Offset(0, 0), end: Offset(0.06, 0)),
        FadeEffect(duration: Duration(milliseconds: 450), curve: Curves.easeOutCubic, begin: 1.0, end: 0.6),
      ],
      target: (displayStateWatcher.settingsExpanded == true) ? 1 : 0,
      child: const SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar(),
            TimerCard(),
            InfoCard(),
          ],
        ),
      ),
    );
  }
}

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final timerWatcher = ref.watch(timerProvider);
    return Container(
      height: 50 * scaleFactor,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.background.withAlpha(180)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(displayStateProvider).toggleSettingsExpanded();
            },
            child: Container(
              width: 50 * scaleFactor,
              height: 50 * scaleFactor,
              color: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.settings_outlined,
                size: 20 * scaleFactor,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              timerWatcher.dispEtc.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: (50 * scaleFactor) + 16,
          ),
        ],
      ),
    );
  }
}

class TimerCard extends ConsumerWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaleFactor = ref.watch(displayStateProvider).displayFontScale;
    return Container(
      margin: EdgeInsets.only(top: 40 * scaleFactor),
      width: MediaQuery.of(context).size.width * 0.6 * scaleFactor,
      height: MediaQuery.of(context).size.height * 0.3 * scaleFactor,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "${ref.watch(timerProvider).mainTimer.inHours.toString().padLeft(2, '0')}:"
          "${ref.watch(timerProvider).mainTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
          "${ref.watch(timerProvider).mainTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
          style: TextStyle(
            fontSize: 116 * scaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class InfoCard extends ConsumerWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Pengumpulan pada pukul ${ref.watch(timerProvider).endAt.hour}:${ref.watch(timerProvider).endAt.minute}"),
      ],
    );
  }
}
