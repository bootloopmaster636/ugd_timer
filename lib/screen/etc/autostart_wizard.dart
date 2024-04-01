import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/logic/timerEtc/autostart_logic.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/ui/navigation.dart';
import 'package:ugd_timer/logic/ui/overlay.dart';
import 'package:ugd_timer/screen/general_components.dart';
import 'package:ugd_timer/screen/top/clock_components.dart';

class AutoStartTimerPage extends HookConsumerWidget {
  const AutoStartTimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime now = ref.watch(timerBeatProvider).value!.now;
    final Duration startAt = ref.watch(autoStartLogicProvider).startAt;
    final String message = ref.watch(autoStartLogicProvider).message;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            Center(
              child: AutoStartTimer(now: now, message: message, startAt: startAt),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: HoverRevealer(
                height: 32,
                decoration: BoxDecoration(
                  color: FluentTheme.of(context).menuColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Button(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        FluentIcons.cancel,
                        size: 16,
                      ),
                      const Gap(4),
                      Text(
                        AppLocalizations.of(context)!.cancel,
                      ),
                    ],
                  ),
                  onPressed: () {
                    ref.read(autoStartLogicProvider.notifier).setAutoStartEnabled(isAutoStartEnabled: false);
                    ref.read(topWidgetLogicProvider.notifier).backToTimer();
                  },
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Column(
                children: <Widget>[
                  Text('state.startat.inhours: ${startAt.inHours}'),
                  Text('state.startat.inminutes % 60: ${startAt.inMinutes % 60}'),
                  Text('DateTime.now().hour: ${DateTime.now().hour}'),
                  Text('DateTime.now().minute: ${DateTime.now().minute}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class AutoStartTimer extends StatelessWidget {
  const AutoStartTimer({
    required this.now,
    required this.message,
    required this.startAt,
    super.key,
  });

  final DateTime now;
  final String message;
  final Duration startAt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedClockWidget(time: Duration(hours: now.hour, minutes: now.minute, seconds: now.second)),
            const Gap(2),
            if (message.isNotEmpty) ...<Widget>[
              const Gap(1),
              Text(
                message,
                style: const TextStyle(fontSize: 3),
              ),
            ],
            Text(
              AppLocalizations.of(context)!.timerWillStartAt(
                startAt.inHours.toString().padLeft(2, '0'),
                (startAt.inMinutes % 60).toString().padLeft(2, '0'),
              ),
              style: const TextStyle(fontSize: 2, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoStartSetupPage extends HookConsumerWidget {
  const AutoStartSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Duration autoStartClockInfo = ref.watch(autoStartLogicProvider).startAt;
    final TextEditingController messageCtl = useTextEditingController();
    final Duration mainTimer = ref.watch(timerLogicProvider).value?.mainTimer ?? Duration.zero;

    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.autoStartWizardAsk,
              style: FluentTheme.of(context).typography.title,
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            HideableWidget(
              isShown: mainTimer == Duration.zero,
              child: SizedBox(
                width: 400,
                child: InfoBar(
                  title: Text(AppLocalizations.of(context)!.warning),
                  content: Text(AppLocalizations.of(context)!.mainTimerNotConfiguredWarning),
                  severity: InfoBarSeverity.warning,
                  isLong: true,
                  action: Button(
                    child: Text(AppLocalizations.of(context)!.timerSettings),
                    onPressed: () {
                      ref.read(overlayStateLogicProvider.notifier).toggleTimerSettings();
                    },
                  ),
                ),
              ),
            ),
            const Gap(16),
            TimePicker(
              hourFormat: HourFormat.HH,
              header: AppLocalizations.of(context)!.pickATime,
              selected: DateTime(0, 0, 0, autoStartClockInfo.inHours, autoStartClockInfo.inMinutes % 60),
              onChanged: (DateTime value) {
                ref
                    .read(autoStartLogicProvider.notifier)
                    .setAutoStartClock(Duration(hours: value.hour, minutes: value.minute));
              },
            ),
            const Gap(8),
            InfoLabel(
              label: AppLocalizations.of(context)!.autoStartMessageHelper,
              child: TextBox(
                controller: messageCtl,
                placeholder: AppLocalizations.of(context)!.autoStartMessageExample,
                onChanged: (String value) {
                  ref.read(autoStartLogicProvider.notifier).setAutoStartMessage(value);
                },
              ),
            ),
            const Gap(16),
            Row(
              children: <Widget>[
                FilledButton(
                  child: Text(
                    AppLocalizations.of(context)!.startTimer,
                  ),
                  onPressed: () {
                    ref.read(topWidgetLogicProvider.notifier).setCurrentlyShown(const AutoStartTimerPage());
                    ref.read(autoStartLogicProvider.notifier).autoStartBeat();
                  },
                ),
                const Gap(8),
                Button(
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                  ),
                  onPressed: () {
                    ref.read(topWidgetLogicProvider.notifier).backToTimer();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
