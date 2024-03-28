// TODO(bootloopmaster636): still buggy. will change this with a different package later
// Future<void> initHotkeys(WidgetRef ref) async {
//   // configure hotkeys
//   final HotKey startTimer = HotKey(
//     KeyCode.keyS,
//     modifiers: <KeyModifier>[KeyModifier.control],
//     scope: HotKeyScope.inapp,
//   );
//   final HotKey stopAndResetTimer = HotKey(
//     KeyCode.keyR,
//     modifiers: <KeyModifier>[KeyModifier.control],
//     scope: HotKeyScope.inapp,
//   );
//   final HotKey timerSettings = HotKey(
//     KeyCode.keyT,
//     modifiers: <KeyModifier>[KeyModifier.control],
//     scope: HotKeyScope.inapp,
//   );
//   final HotKey appSettings = HotKey(
//     KeyCode.keyO,
//     modifiers: <KeyModifier>[KeyModifier.control],
//     scope: HotKeyScope.inapp,
//   );
//
//   // register hotkeys
//   await hotKeyManager.register(
//     startTimer,
//     keyDownHandler: (HotKey hotKey) {
//       Logger().i('Timer started via shortcut');
//       ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
//     },
//   );
//   await hotKeyManager.register(
//     stopAndResetTimer,
//     keyDownHandler: (HotKey hotKey) {
//       ref.read(timerLogicProvider.notifier).resetTimer();
//     },
//   );
//   await hotKeyManager.register(
//     timerSettings,
//     keyDownHandler: (HotKey hotKey) {},
//   );
//   await hotKeyManager.register(
//     appSettings,
//     keyDownHandler: (HotKey hotKey) {},
//   );
// }
