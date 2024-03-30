import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerEtc/timer_notes.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/ui/overlay.dart';
import 'package:ugd_timer/screen/general_components.dart';
import 'package:ugd_timer/screen/top/notes.dart';
import 'package:ugd_timer/screen/top/timer.dart';

class MainTimer extends ConsumerWidget {
  const MainTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isNotesShown = ref.watch(notesLogicProvider).isShown;
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 7,
                    child: Container(
                      width: 60.w,
                      constraints: BoxConstraints(
                        maxWidth: 120.h,
                      ),
                      child: const FittedBox(
                        child: Timer(),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: isNotesShown ? 5 : 0,
                    child: HideableWidget(
                      isShown: isNotesShown,
                      child: const Row(
                        children: <Widget>[
                          Gap(16),
                          Expanded(child: NotesCard()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
      child: const CompactControlBarContent(),
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
          icon: const Icon(FluentIcons.quick_note),
          onPressed: () {
            ref.read(notesLogicProvider.notifier).toggleNotes();
          },
        ),
      ],
    );
  }
}
