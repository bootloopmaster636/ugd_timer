import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  Future<void> setTimer(Duration newCurrentTimer, Duration newAssistTimer, Duration newBonusTimer) async {
    state = AsyncData<Clock>(
      Clock(
        currentTimer: newCurrentTimer,
        assistTimer: newAssistTimer,
        bonusTimer: newBonusTimer,
      ),
    );
  }
}
