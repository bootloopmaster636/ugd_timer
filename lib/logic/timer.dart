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
    );
  }

  Future<void> setTimer(
    TimerType type,
    Duration duration,
  ) async {
    switch (type) {
      case TimerType.main:
        state = AsyncData<Clock>(
          Clock(
            currentTimer: duration,
            assistTimer: state.value?.assistTimer ?? Duration.zero,
            bonusTimer: state.value?.bonusTimer ?? Duration.zero,
          ),
        );

      case TimerType.assist:
        state = AsyncData<Clock>(
          Clock(
            currentTimer: state.value?.currentTimer ?? Duration.zero,
            assistTimer: duration,
            bonusTimer: state.value?.bonusTimer ?? Duration.zero,
          ),
        );

      case TimerType.bonus:
        state = AsyncData<Clock>(
          Clock(
            currentTimer: state.value?.currentTimer ?? Duration.zero,
            assistTimer: state.value?.assistTimer ?? Duration.zero,
            bonusTimer: duration,
          ),
        );
    }
  }

  Future<void> resetTimer() async {
    state = AsyncData<Clock>(
      Clock(
        currentTimer: Duration.zero,
        assistTimer: Duration.zero,
        bonusTimer: Duration.zero,
      ),
    );
    await ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
  }

  Future<void> decrementTimer() async {
    Clock clock = state.value ??
        Clock(
          currentTimer: Duration.zero,
          assistTimer: Duration.zero,
          bonusTimer: Duration.zero,
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
    await timerBeatLogic();
    return TimerStatus.stopped;
  }

  Future<void> setTimerStatus(TimerStatus newStatus) async {
    state = AsyncData<TimerStatus>(newStatus);
  }

  Future<void> timerBeatLogic() async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final TimerStatus status = state.value ?? TimerStatus.stopped;
      switch (status) {
        case TimerStatus.running:
          if (ref.read(timerLogicProvider).value?.currentTimer.inSeconds == 0) {
            ref.read(timerLogicProvider.notifier).resetTimer();
          }
          ref.read(timerLogicProvider.notifier).decrementTimer();
        case TimerStatus.stopped:
          //do nothing
          break;
      }
    });
  }
}
