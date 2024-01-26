import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timer.dart';

Future<void> initHotkeys(BuildContext context, WidgetRef ref) async {
  // configure hotkeys
  final HotKey startTimer = HotKey(
    KeyCode.keyS,
    modifiers: <KeyModifier>[KeyModifier.control],
  );
  final HotKey stopAndResetTimer = HotKey(
    KeyCode.keyR,
    modifiers: <KeyModifier>[KeyModifier.control],
  );
  final HotKey timerSettings = HotKey(
    KeyCode.keyT,
    modifiers: <KeyModifier>[KeyModifier.control],
  );
  final HotKey appSettings = HotKey(
    KeyCode.keyO,
    modifiers: <KeyModifier>[KeyModifier.control],
  );

  // register hotkeys
  await hotKeyManager.register(
    startTimer,
    keyDownHandler: (HotKey hotKey) {
      ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
    },
  );
  await hotKeyManager.register(
    stopAndResetTimer,
    keyDownHandler: (HotKey hotKey) {
      ref.read(timerLogicProvider.notifier).resetTimer();
    },
  );
  await hotKeyManager.register(
    timerSettings,
    keyDownHandler: (HotKey hotKey) {},
  );
  await hotKeyManager.register(
    appSettings,
    keyDownHandler: (HotKey hotKey) {},
  );
}
