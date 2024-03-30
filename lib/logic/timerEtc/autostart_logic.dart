import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/ui/navigation.dart';

part 'autostart_logic.freezed.dart';
part 'autostart_logic.g.dart';

@freezed
class AutoStartClock with _$AutoStartClock {
  factory AutoStartClock({
    required Duration startAt,
    required String message,
    required bool enabled,
  }) = _AutoStartClock;
}

@riverpod
class AutoStartLogic extends _$AutoStartLogic {
  @override
  AutoStartClock build() {
    final DateTime now = DateTime.now();
    return AutoStartClock(
      startAt: Duration(hours: now.hour, minutes: now.minute),
      message: '',
      enabled: false,
    );
  }

  void setAutoStartClock(Duration startAt) {
    state = state.copyWith(startAt: startAt);
  }

  void setAutoStartEnabled({required bool isAutoStartEnabled}) {
    state = state.copyWith(enabled: isAutoStartEnabled);
  }

  void setAutoStartMessage(String message) {
    state = state.copyWith(message: message);
  }

  void autoStartBeat() {
    state = state.copyWith(enabled: true);
    ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (state.enabled) {
        // when now and the duration set by the user is the same, start the main timer
        Logger().i('stopping timer');
        if (state.startAt.inHours == DateTime.now().hour && state.startAt.inMinutes % 60 == DateTime.now().minute) {
          ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.running);
          ref.read(topWidgetLogicProvider.notifier).backToTimer();
          state = state.copyWith(enabled: false, message: '', startAt: Duration.zero); //reset the timer
          timer.cancel();
        }
      } else {
        timer.cancel();
      }
    });
  }
}
