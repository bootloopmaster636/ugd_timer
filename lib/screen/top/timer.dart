import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/timerMain/timer_conf.dart';
import 'package:ugd_timer/screen/general_components.dart';
import 'package:ugd_timer/screen/top/clock_components.dart';

// const Duration clockProvider = Duration.zero;

class Timer extends HookConsumerWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Duration mainClock = ref.watch(timerLogicProvider).value?.mainTimer ?? Duration.zero;
    return Column(
      children: <Widget>[
        HideableWidget(
          isShown: ref.watch(timerConfLogicProvider).title.isNotEmpty,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  ref.watch(timerConfLogicProvider).title,
                  style: const TextStyle(
                    fontSize: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gap(0.6.h),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          clipBehavior: Clip.hardEdge,
          child: Container(
            decoration: BoxDecoration(
              color: FluentTheme.of(context).menuColor.withOpacity(0.9),
              border: Border.all(
                color: FluentTheme.of(context).accentColor.dark,
                width: 0.4,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: AnimatedClockWidget(
              time: mainClock,
            ),
          ),
        ),
        Gap(0.8.h),
        const TimerInfo(),
      ],
    );
  }
}

class TimerInfo extends ConsumerWidget {
  const TimerInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Duration assistClock = ref.watch(timerLogicProvider).value?.assistTimer ?? Duration.zero;
    final Duration bonusClock = ref.watch(timerLogicProvider).value?.bonusTimer ?? Duration.zero;
    return Row(
      children: <HideableWidget>[
        HideableWidget(
          isShown: ref.watch(timerConfLogicProvider).assistTimerEnabled,
          child: Row(
            children: <Widget>[
              const FaIcon(
                FontAwesomeIcons.personCircleQuestion,
                size: 5,
              ),
              const Gap(2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.assistAvailableIn, style: const TextStyle(fontSize: 2)),
                  Text(
                    '${AppLocalizations.of(context)!.minutes(assistClock.inMinutes)} ${AppLocalizations.of(context)!.seconds(assistClock.inSeconds % 60)}',
                    style: const TextStyle(fontSize: 3, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        HideableWidget(
          isShown: ref.watch(timerConfLogicProvider).bonusTimerEnabled,
          child: Row(
            children: <Widget>[
              const FaIcon(
                FontAwesomeIcons.anglesUp,
                size: 5,
              ),
              const Gap(2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.timeUntilBonusExpired, style: const TextStyle(fontSize: 2)),
                  Text(
                    '${AppLocalizations.of(context)!.minutes(bonusClock.inMinutes)} ${AppLocalizations.of(context)!.seconds(bonusClock.inSeconds % 60)}',
                    style: const TextStyle(fontSize: 3, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ].map((HideableWidget e) => Padding(padding: const EdgeInsets.symmetric(horizontal: 2), child: e)).toList(),
    );
  }
}
