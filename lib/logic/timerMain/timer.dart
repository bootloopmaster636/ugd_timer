import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/ui/accent_color.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class Clock with _$Clock {
  factory Clock({
    required Duration mainTimer,
    required Duration assistTimer,
    required Duration bonusTimer,
    @Default(Duration.zero) Duration mainTimerFreezed,
  }) = _Clock;

  factory Clock.fromJson(Map<String, dynamic> json) => _$ClockFromJson(json);
}

@freezed
class Status with _$Status {
  factory Status({
    required TimerStatus status,
    required DateTime now,
  }) = _Status;
}

@riverpod
class TimerLogic extends _$TimerLogic {
  @override
  Future<Clock> build() async {
    return Clock(
      mainTimer: Duration.zero,
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
            mainTimer: duration,
            mainTimerFreezed: duration,
            assistTimer: state.value?.assistTimer ?? Duration.zero,
            bonusTimer: state.value?.bonusTimer ?? Duration.zero,
          ),
        );

      case TimerType.assist:
        state = AsyncData<Clock>(
          Clock(
            mainTimer: state.value?.mainTimer ?? Duration.zero,
            mainTimerFreezed: state.value?.mainTimerFreezed ?? Duration.zero,
            assistTimer: duration,
            bonusTimer: state.value?.bonusTimer ?? Duration.zero,
          ),
        );

      case TimerType.bonus:
        state = AsyncData<Clock>(
          Clock(
            mainTimer: state.value?.mainTimer ?? Duration.zero,
            mainTimerFreezed: state.value?.mainTimerFreezed ?? Duration.zero,
            assistTimer: state.value?.assistTimer ?? Duration.zero,
            bonusTimer: duration,
          ),
        );
    }
  }

  Future<void> resetTimer() async {
    state = AsyncData<Clock>(
      Clock(
        mainTimer: Duration.zero,
        assistTimer: Duration.zero,
        bonusTimer: Duration.zero,
      ),
    );
    await ref.read(timerBeatProvider.notifier).setTimerStatus(TimerStatus.stopped);
  }

  Future<void> decrementTimer() async {
    Clock clock = state.value ??
        Clock(
          mainTimer: Duration.zero,
          assistTimer: Duration.zero,
          bonusTimer: Duration.zero,
        );

    if (clock.mainTimer.inSeconds > 0) {
      clock = clock.copyWith(mainTimer: clock.mainTimer - const Duration(seconds: 1));

      // change accent color based on how much time is left
      // ignore: avoid_manual_providers_as_generated_provider_dependency
      ref.read(accentColorStateProvider.notifier).setAccentColorByDuration(clock.mainTimer, clock.mainTimerFreezed);
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
  Future<Status> build() async {
    await timerBeatLogic();
    return Status(
      status: TimerStatus.stopped,
      now: DateTime.now(),
    );
  }

  Future<void> setTimerStatus(TimerStatus newStatus) async {
    final Status status = state.value ??
        Status(
          status: TimerStatus.stopped,
          now: DateTime.now(),
        );
    state = AsyncData<Status>(
      status.copyWith(
        status: newStatus,
        now: DateTime.now(),
      ),
    );
  }

  Future<void> timerBeatLogic() async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final Status timerStatus = state.value ??
          Status(
            status: TimerStatus.stopped,
            now: DateTime.now(),
          );

      switch (timerStatus.status) {
        case TimerStatus.running:
          if (ref.read(timerLogicProvider).value?.mainTimer.inSeconds == 0) {
            ref.read(timerLogicProvider.notifier).resetTimer();
          }
          ref.read(timerLogicProvider.notifier).decrementTimer();
        case TimerStatus.stopped:
          //do nothing
          break;
      }
      state = AsyncData<Status>(timerStatus.copyWith(now: DateTime.now()));
    });
  }
}
