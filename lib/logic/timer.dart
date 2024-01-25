import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugd_timer/constants.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class Clock with _$Clock {
  factory Clock({
    required Duration currentTimer,
    required Duration assistTimer,
    required Duration bonusTimer,
    required TimerStatus status,
  }) = _Clock;
}

class Status {
  Status({required this.status});

  TimerStatus status;
}

@riverpod
class TimerLogic extends _$TimerLogic {
  @override
  Future<Clock> build() async {
    return Clock(
      currentTimer: Duration.zero,
      assistTimer: Duration.zero,
      bonusTimer: Duration.zero,
      status: TimerStatus.reset,
    );
  }

  Future<void> setTimer(Duration newCurrentTimer, Duration newAssistTimer, Duration newBonusTimer) async {
    state = AsyncData<Clock>(
      Clock(
        currentTimer: newCurrentTimer,
        assistTimer: newAssistTimer,
        bonusTimer: newBonusTimer,
        status: TimerStatus.reset,
      ),
    );
  }

  Future<void> resetTimer() async {
    state = AsyncData<Clock>(
      Clock(
        currentTimer: Duration.zero,
        assistTimer: Duration.zero,
        bonusTimer: Duration.zero,
        status: TimerStatus.reset,
      ),
    );
  }

  Future<void> decrementTimer() async {
    Clock clock = state.value ??
        Clock(
          currentTimer: Duration.zero,
          assistTimer: Duration.zero,
          bonusTimer: Duration.zero,
          status: TimerStatus.reset,
        );

    if (clock.currentTimer.inSeconds > 0) {
      clock = clock.copyWith(currentTimer: clock.currentTimer - const Duration(seconds: 1));
    }

    if (clock.assistTimer.inSeconds > 0) {
      clock = clock.copyWith(assistTimer: clock.assistTimer - const Duration(seconds: 1));
    }

    if (clock.bonusTimer.inSeconds > 0) {
      clock = clock.copyWith(bonusTimer: clock.bonusTimer - const Duration(seconds: 1));
    }

    state = AsyncData<Clock>(clock);
  }
}

@riverpod
class TimerBeat extends _$TimerBeat {
  @override
  Future<TimerStatus> build() async {
    return TimerStatus.reset;
  }

  Future<void> setTimerStatus(TimerStatus newStatus) async {
    state = AsyncData<TimerStatus>(newStatus);
  }

  void timerBeatLogic() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final TimerStatus status = state.value ?? TimerStatus.reset;
      switch (status) {
        case TimerStatus.reset:
          ref.read(timerLogicProvider.notifier).resetTimer();
        case TimerStatus.running:
          ref.read(timerLogicProvider.notifier).decrementTimer();
        case TimerStatus.paused:
          //do nothing
          break;
      }
    });
  }
}
