import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd_timer/logic/managers/TimerManager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:ugd_timer/main.dart';

class TopLayer extends ConsumerWidget {
  const TopLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaleFactor = ref.watch(displayStateProvider).displayFontScale;
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
            end: 0.4
        ),
      ],
      target: (displayStateWatcher.settingsExpanded == true) ? 1 : 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopBar(),
          SizedBox(
            height: MediaQuery.of(context).size.height - 60 * scaleFactor,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TimerCard(),
                InfoCard(),
              ],
            ),
          ),
        ],
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
    final timerManager = ref.watch(timerProvider).timerManager;
    final displayStateWatcher = ref.watch(displayStateProvider);
    final isFullScreenNotifier = ref.watch(fullscreenProvider);

    void showToastLocal(String msg) {
      showToast(msg, context: context);
    }

    // not defining ref.read(...) into a variable because documentation said it's bad practice, and causing bugs

    return Container(
      height: 60 * scaleFactor,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withAlpha(180)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {
              displayStateWatcher.toggleSettingsExpanded();
            },
            child: Container(
              width: 60 * scaleFactor,
              height: 60 * scaleFactor,
              color: Theme.of(context).colorScheme.tertiary,
              child: Icon(
                Icons.settings_outlined,
                size: 22 * scaleFactor,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () async {
              bool currentFullScreen =
                  await WindowManager.instance.isFullScreen();

              WindowManager.instance.setFullScreen(!currentFullScreen);
              showToastLocal(currentFullScreen
                  ? "Window has been restored"
                  : "Window has been maximized");

              isFullScreenNotifier.value = !currentFullScreen;
            },
            child: Container(
              width: 60 * scaleFactor,
              height: 60 * scaleFactor,
              color: Theme.of(context).colorScheme.secondary,
              child: Icon(
                isFullScreenNotifier.value
                    ? Icons.fullscreen_exit
                    : Icons.fullscreen,
                size: 22 * scaleFactor,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              timerWatcher.displayManager.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
          ),
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {
              if (timerManager.isTimerSet(TimerType.main)) {
                if (ref.read(timerProvider).isSet) {
                  showToast(
                    "Timer has been ${ref.read(timerProvider).isRunning ? "paused" : "resumed"}",
                    context: context,
                  );
                } else {
                  showToast("Timer has been started", context: context);
                }
                ref.read(timerProvider).toggleTimer();
              } else {
                showToast(
                  "Timer has not been initialized yet...",
                  context: context,
                );
              }
            },
            child: Container(
              width: 60 * scaleFactor,
              height: 60 * scaleFactor,
              color: Theme.of(context).colorScheme.primary,
              child: Icon(
                ref.read(timerProvider).isRunning
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 22 * scaleFactor,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {
              if (timerManager.isTimerSet(TimerType.main)) {
                ref.read(timerProvider).stopAndResetTimer(isPressed: true);
                showToast("Timer has been reset", context: context);
              } else {
                showToast(
                  "Timer has not been initialized yet...",
                  context: context,
                );
              }
            },
            child: Container(
              width: 60 * scaleFactor,
              height: 60 * scaleFactor,
              color: Theme.of(context).colorScheme.secondary,
              child: Icon(
                Icons.replay,
                size: 22 * scaleFactor,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
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
    final timerWatcher = ref.watch(timerProvider);
    final timerManager = ref.watch(timerProvider).timerManager;

    return Container(
      margin: EdgeInsets.only(top: 20 * scaleFactor),
      width: 800 * scaleFactor,
      height: 220 * scaleFactor,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "${timerManager.getTimer(TimerType.main).inHours.toString().padLeft(2, '0')}:"
          "${timerManager.getTimer(TimerType.main).inMinutes.remainder(60).toString().padLeft(2, '0')}:"
          "${timerManager.getTimer(TimerType.main).inSeconds.remainder(60).toString().padLeft(2, '0')}",
          style: TextStyle(
            fontSize: 116,
            fontWeight: FontWeight.w600,
            color: (timerWatcher.isCutOffRunning) &&
                    (timerManager.getTimer(TimerType.main).inSeconds % 2 == 0)
                ? Colors.red
                : null,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class InfoCard extends ConsumerWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaleFactor = ref.watch(displayStateProvider).displayFontScale;
    final timerWatcher = ref.watch(timerProvider);
    final timerManager = ref.watch(timerProvider).timerManager;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "${timerWatcher.isCutOffRunning ? "Cut Off" : "Pengumpulan"} pada pukul",
                    style: TextStyle(
                      fontSize:
                          timerWatcher.isCutOffRunning ? 36 : 28 * scaleFactor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${timerManager.endAt.hour.toString().padLeft(2, '0')}:${timerManager.endAt.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 48 * scaleFactor,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  Text(
                    timerManager.isTimerSet(TimerType.cutoff)
                        ? "Cutoff di-set selama ${timerManager.getTimer(TimerType.cutoff).inMinutes} menit"
                        : "",
                    style: TextStyle(
                      fontSize: 20 * scaleFactor,
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 24 * scaleFactor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.personCircleQuestion,
                size: 64 * scaleFactor,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              SizedBox(
                width: 24 * scaleFactor,
              ),
              RichText(
                text: TextSpan(
                  text: "Dapat bertanya asisten setelah\n",
                  style: TextStyle(
                      fontSize: 24 * scaleFactor,
                      fontFamily:
                          Theme.of(context).textTheme.displayMedium!.fontFamily,
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                  children: [
                    TextSpan(
                      text:
                          "${timerManager.getTimer(TimerType.assist).inMinutes.toString().padLeft(2, '0')} menit "
                          "${timerManager.getTimer(TimerType.assist).inSeconds.remainder(60).toString().padLeft(2, '0')} detik",
                      style: TextStyle(
                          fontSize: 32 * scaleFactor,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40 * scaleFactor),
                height: 72 * scaleFactor,
                child: VerticalDivider(
                  color: Theme.of(context).colorScheme.onBackground,
                  thickness: 6,
                ),
              ),
              Icon(
                FontAwesomeIcons.anglesUp,
                size: 64 * scaleFactor,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              SizedBox(
                width: 12 * scaleFactor,
              ),
              RichText(
                text: TextSpan(
                  text: "Sisa waktu bonus\n",
                  style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.displayMedium!.fontFamily,
                      fontSize: 24 * scaleFactor,
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                  children: [
                    TextSpan(
                      text:
                          "${timerManager.getTimer(TimerType.bonus).inMinutes.toString().padLeft(2, '0')} menit "
                          "${timerManager.getTimer(TimerType.bonus).inSeconds.remainder(60).toString().padLeft(2, '0')} detik",
                      style: TextStyle(
                          fontSize: 32 * scaleFactor,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
