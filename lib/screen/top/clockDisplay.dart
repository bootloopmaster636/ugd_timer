import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/ui/overlay.dart';
import 'package:ugd_timer/screen/generalComponents.dart';
import 'package:ugd_timer/screen/top/timer.dart';

class MainTimer extends StatelessWidget {
  const MainTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraint) {
        return Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            const Positioned(
              top: 16,
              left: 16,
              child: CompactControlBar(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 72.w,
                  constraints: BoxConstraints(
                    maxWidth: 120.h,
                  ),
                  child: const FittedBox(
                    child: Timer(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CompactControlBar extends ConsumerWidget {
  const CompactControlBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HoverRevealer(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).menuColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CompactControlBarContent(),
    );
  }
}

class CompactControlBarContent extends ConsumerWidget {
  const CompactControlBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TimerStatus status = ref.watch(timerBeatProvider).value?.status ?? TimerStatus.stopped;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(status == TimerStatus.stopped ? FluentIcons.play : FluentIcons.pause),
          onPressed: () {
            if (status == TimerStatus.stopped) {
              ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
            } else {
              ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
            }
          },
        ),
        IconButton(
          icon: const Icon(FluentIcons.reset),
          onPressed: () {
            ref.read(timerLogicProvider.notifier).resetTimer();
          },
        ),
        const Gap(4),
        const Divider(
          size: 16,
          direction: Axis.vertical,
          style: DividerThemeData(
            thickness: 2,
          ),
        ),
        const Gap(4),
        IconButton(
          icon: const Icon(FluentIcons.timer),
          onPressed: () {
            ref.read(overlayStateLogicProvider.notifier).toggleTimerSettings();
          },
        ),
      ],
    );
  }
}