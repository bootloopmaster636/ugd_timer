import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timer.dart';
import 'package:ugd_timer/logic/timerEtc.dart';
import 'package:ugd_timer/screen/overlay/settingsComponent.dart';

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
          selectedTime: ref.watch(timerLogicProvider).value?.currentTimer ?? Duration.zero,
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
    return SettingsSection(
      title: AppLocalizations.of(context)!.assistTimer,
      subtitle: AppLocalizations.of(context)!.assistTimerDesc,
      children: <Widget>[
        SettingsTileSwitch(
          title: AppLocalizations.of(context)!.enable,
          value: ref.watch(timerEtcLogicProvider).assistTimerEnabled,
          onChanged: (bool value) {
            ref.read(timerEtcLogicProvider.notifier).setAssistTimerEnabled(assistTimerEnabled: value);
          },
        ),
        SettingsTileTimeSelect(
          title: AppLocalizations.of(context)!.setTimer,
          selectedTime: ref.watch(timerLogicProvider).value?.assistTimer ?? Duration.zero,
          isEnabled: ref.watch(timerEtcLogicProvider).assistTimerEnabled,
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
    return SettingsSection(
      title: AppLocalizations.of(context)!.bonusTimer,
      subtitle: AppLocalizations.of(context)!.bonusTimerDesc,
      children: <Widget>[
        SettingsTileSwitch(
          title: AppLocalizations.of(context)!.enable,
          value: ref.watch(timerEtcLogicProvider).bonusTimerEnabled,
          onChanged: (bool value) {
            ref.read(timerEtcLogicProvider.notifier).setBonusTimerEnabled(bonusTimerEnabled: value);
          },
        ),
        SettingsTileTimeSelect(
          title: AppLocalizations.of(context)!.setTimer,
          selectedTime: ref.watch(timerLogicProvider).value?.bonusTimer ?? Duration.zero,
          isEnabled: ref.watch(timerEtcLogicProvider).bonusTimerEnabled,
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
      children: [
        SettingsTileTextfield(
          title: AppLocalizations.of(context)!.setTimerTitle,
          hint: AppLocalizations.of(context)!.enterText,
          isEnabled: true,
          onChanged: (String text) {
            ref.read(timerEtcLogicProvider.notifier).setTitle(text);
          },
        ),
      ],
    );
  }
}
