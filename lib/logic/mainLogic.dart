import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ugd_timer/logic/themeAndInfo.dart';

class TimerController extends ChangeNotifier {
  bool _isRunning = false;
  Duration _mainTimerFreezed = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _mainTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _assistTimer = const Duration(minutes: 0, seconds: 0);
  Duration _bonusTimer = const Duration(minutes: 0, seconds: 0);
  TimeOfDay _endAt = const TimeOfDay(hour: 0, minute: 0);
  final DisplayEtc _dispEtc =
      DisplayEtc("", Colors.lightBlue, ThemeMode.system);

// ============== Time getter =============
  bool get isRunning => _isRunning;

  Duration get mainTimerFreezed => _mainTimerFreezed;

  Duration get mainTimer => _mainTimer;

  Duration get assistTimer => _assistTimer;

  Duration get bonusTimer => _bonusTimer;

  DisplayEtc get dispEtc => _dispEtc;

  TimeOfDay get endAt => _endAt;

  // ============= Time setter ==============
  void setMainTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _mainTimer = Duration(
          hours: timeFromPicker!.hour,
          minutes: timeFromPicker.minute,
          seconds: 0);
      _mainTimerFreezed = Duration(
          hours: timeFromPicker.hour,
          minutes: timeFromPicker.minute,
          seconds: 0);
    } else {
      _mainTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
    }
    notifyListeners();
  }

  void setAssistTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _assistTimer = Duration(
          hours: timeFromPicker!.hour,
          minutes: timeFromPicker.minute,
          seconds: 0);
    } else {
      _assistTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
    }
    notifyListeners();
  }

  void setBonusTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _bonusTimer = Duration(
          hours: timeFromPicker!.hour,
          minutes: timeFromPicker.minute,
          seconds: 0);
    } else {
      _bonusTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
    }
    notifyListeners();
  }

  // ============= Timer manager module  =============
  void decrementTimer(String timertype) async {
    switch (timertype) {
      case "main":
        _mainTimer -= const Duration(seconds: 1);

        break;

      case "assist":
        if (_assistTimer.inSeconds > 0) {
          _assistTimer -= const Duration(seconds: 1);
        }

        break;

      case "bonus":
        if (_bonusTimer.inSeconds > 0) {
          _bonusTimer -= const Duration(seconds: 1);
        }

        break;
    }
  }

  void makeEndAt() async {
    Duration now =
        Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);
    Duration res = mainTimer + now;

    //set new hour
    int hour = res.inHours % 24;
    // set new minute
    int minute = res.inMinutes % 60;

    _endAt = TimeOfDay(hour: hour, minute: minute);
  }

  // ========== Timer manager ===========
  void startTimer() async {
    if (_mainTimer.inSeconds == 0) {
      return;
    }

    _isRunning = true;
    startCountdown();
    notifyListeners();
  }

  void pauseTimer() async {
    _isRunning = false;
    notifyListeners();
  }

  void stopAndResetTimer() {
    _isRunning = false;
    setMainTimer(reset: true);
    setAssistTimer(reset: true);
    setBonusTimer(reset: true);
    _endAt = const TimeOfDay(hour: 0, minute: 0);
    notifyListeners();
  }

  void startCountdown() async {
    makeEndAt();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning && _mainTimer.inSeconds > 0) {
        decrementTimer("main");
        decrementTimer("assist");
        decrementTimer("bonus");
        _dispEtc.dynamicAccentChanger(_mainTimer, _mainTimerFreezed);
      } else if (!_isRunning && _mainTimer.inSeconds > 0) {
        timer.cancel();
      } else {
        stopAndResetTimer();
      }
      notifyListeners();
    });
  }

  // ============= App config interface =============
  void setTitle(String s) {
    _dispEtc.setTitle(s);
    notifyListeners();
  }

  void changeThemeMode(String s) {
    _dispEtc.changeThemeMode(s);
    notifyListeners();
  }
}
