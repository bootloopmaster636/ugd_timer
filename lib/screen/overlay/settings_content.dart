import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/timerMain/timer_conf.dart';
import 'package:ugd_timer/screen/overlay/settings_component.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MainTimerSection(),
        AssistTimerSection(),
        BonusTimerSection(),
        TimerTitleSection(),
      ],
    );
  }
}

class MainTimerSection extends ConsumerWidget {
  const MainTimerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.mainTimer,
      subtitle: AppLocalizations.of(context)!.mainTimerDesc,
      children: <Widget>[
        SettingsTileTimeSelect(
          title: AppLocalizations.of(context)!.setTimer,
          selectedTime: ref.watch(timerLogicProvider).value?.mainTimer ?? Duration.zero,
          isEnabled: true,
          onPressed: (DateTime time) {
            ref
                .read(timerLogicProvider.notifier)
                .setTimer(TimerType.main, Duration(hours: time.hour, minutes: time.minute, seconds: time.second));
          },
        ),
      ],
    );
  }
}

class AssistTimerSection extends ConsumerWidget {
  const AssistTimerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // functions as a warning when user set this timer duration above main timer
    ref.listen(
      timerLogicProvider,
      (AsyncValue<Clock>? prevClock, AsyncValue<Clock> newClock) async {
        if (newClock.value!.assistTimer > newClock.value!.mainTimer) {
          await warnTimeExceedMain(context);
          await ref.read(timerLogicProvider.notifier).setTimer(TimerType.assist, Duration.zero);
        }
      },
    );

    return SettingsSection(
      title: AppLocalizations.of(context)!.assistTimer,
      subtitle: AppLocalizations.of(context)!.assistTimerDesc,
      children: <Widget>[
        SettingsTileSwitch(
          title: AppLocalizations.of(context)!.enable,
          value: ref.watch(timerConfLogicProvider).assistTimerEnabled,
          onChanged: (bool value) {
            ref.read(timerConfLogicProvider.notifier).setAssistTimerEnabled(assistTimerEnabled: value);
          },
        ),
        SettingsTileTimeSelect(
          title: AppLocalizations.of(context)!.setTimer,
          selectedTime: ref.watch(timerLogicProvider).value?.assistTimer ?? Duration.zero,
          isEnabled: ref.watch(timerConfLogicProvider).assistTimerEnabled,
          onPressed: (DateTime time) {
            ref
                .read(timerLogicProvider.notifier)
                .setTimer(TimerType.assist, Duration(hours: time.hour, minutes: time.minute, seconds: time.second));
          },
        ),
      ],
    );
  }
}

class BonusTimerSection extends ConsumerWidget {
  const BonusTimerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // functions as a warning when user set this timer duration above main timer
    ref.listen(
      timerLogicProvider,
      (AsyncValue<Clock>? prevClock, AsyncValue<Clock> newClock) async {
        if (newClock.value!.bonusTimer > newClock.value!.mainTimer) {
          await warnTimeExceedMain(context);
          await ref.read(timerLogicProvider.notifier).setTimer(TimerType.bonus, Duration.zero);
        }
      },
    );

    return SettingsSection(
      title: AppLocalizations.of(context)!.bonusTimer,
      subtitle: AppLocalizations.of(context)!.bonusTimerDesc,
      children: <Widget>[
        SettingsTileSwitch(
          title: AppLocalizations.of(context)!.enable,
          value: ref.watch(timerConfLogicProvider).bonusTimerEnabled,
          onChanged: (bool value) {
            ref.read(timerConfLogicProvider.notifier).setBonusTimerEnabled(bonusTimerEnabled: value);
          },
        ),
        SettingsTileTimeSelect(
          title: AppLocalizations.of(context)!.setTimer,
          selectedTime: ref.watch(timerLogicProvider).value?.bonusTimer ?? Duration.zero,
          isEnabled: ref.watch(timerConfLogicProvider).bonusTimerEnabled,
          onPressed: (DateTime time) {
            ref
                .read(timerLogicProvider.notifier)
                .setTimer(TimerType.bonus, Duration(hours: time.hour, minutes: time.minute, seconds: time.second));
          },
        ),
      ],
    );
  }
}

class TimerTitleSection extends ConsumerWidget {
  const TimerTitleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.timerTitle,
      subtitle: AppLocalizations.of(context)!.timerTitleDesc,
      children: <Widget>[
        SettingsTileTextfield(
          title: AppLocalizations.of(context)!.setTimerTitle,
          hint: AppLocalizations.of(context)!.enterText,
          value: ref.watch(timerConfLogicProvider).title,
          isEnabled: true,
          onChanged: (String text) {
            ref.read(timerConfLogicProvider.notifier).setTitle(text);
          },
        ),
      ],
    );
  }
}

Future<void> warnTimeExceedMain(BuildContext context) async {
  await displayInfoBar(
    context,
    duration: const Duration(seconds: 6),
    builder: (BuildContext context, void Function() close) {
      return InfoBar(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(AppLocalizations.of(context)!.timerCouldNotExceedMain),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: InfoBarSeverity.error,
      );
    },
  );
}
