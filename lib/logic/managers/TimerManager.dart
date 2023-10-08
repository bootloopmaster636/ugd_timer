import 'package:flutter/material.dart';

enum TimerType { main, mainFreeze, assist, bonus, cutoff }

class TimerManager {
  final Map<TimerType, Duration> _timers = {
    TimerType.main: Duration.zero,
    TimerType.mainFreeze: Duration.zero,
    TimerType.assist: Duration.zero,
    TimerType.bonus: Duration.zero,
    TimerType.cutoff: Duration.zero,
  };

  TimeOfDay _endAt = const TimeOfDay(hour: 0, minute: 0);

  Duration getTimer(TimerType timerType) {
    return _timers[timerType] ?? Duration.zero;
  }

  void setTimerFromPicker(TimerType timerType, TimeOfDay? timeFromPicker) {
    Duration fromPicker = Duration(
        hours: timeFromPicker!.hour,
        minutes: timeFromPicker.minute,
        seconds: 0);

    if (timerType == TimerType.main) {
      _timers[TimerType.main] = fromPicker;
      _timers[TimerType.mainFreeze] = fromPicker;

      // Make other timer to zero if main is less than other timer
      _timers.forEach((key, value) {
        if (_timers[key]!.inSeconds > fromPicker.inSeconds &&
            !(key == TimerType.main || key == TimerType.mainFreeze)) {
          _timers[key] = Duration.zero;
        }
      });
    } else if (_timers[TimerType.main] != null) {
      _timers[timerType] = fromPicker;
    }
  }

  void setTimerDuration(TimerType timerType, Duration duration) {
    _timers[timerType] = duration;
  }

  void decrementTimer(TimerType timerType) {
    if (_timers.containsKey(timerType) && _timers[timerType]!.inSeconds > 0) {
      _timers[timerType] = _timers[timerType]! - const Duration(seconds: 1);
    }
  }

  void resetTimers() {
    _timers.forEach((key, value) {
      _timers[key] = Duration.zero;
    });
  }

  void addCutOfftoMain() {
    _timers[TimerType.main] =
        _timers[TimerType.main]! + _timers[TimerType.cutoff]!;
  }

  void makeEndAt() {
    final now =
        Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);
    final res = getTimer(TimerType.main) + now;
    final hour = res.inHours % 24;
    final minute = res.inMinutes % 60;

    _endAt = TimeOfDay(hour: hour, minute: minute);
  }

  bool isTimerSet(TimerType timerType) {
    return _timers[timerType]!.inSeconds > 0;
  }

  TimeOfDay get endAt => _endAt;
  TimeOfDay setEndAt(TimeOfDay time) => _endAt = time;
}
