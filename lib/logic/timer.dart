import 'dart:async';

import 'package:flutter/material.dart';

class TimerController extends ChangeNotifier {
  bool _isRunning = false;
  Duration _mainTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _assistTimer = const Duration(minutes: 0, seconds: 0);
  Duration _bonusTimer = const Duration(minutes: 0, seconds: 0);
  TimeOfDay _endAt = const TimeOfDay(hour: 0, minute: 0);

// ============== Time getter =============
  bool get isRunning => _isRunning;

  Duration get displayTimer => _mainTimer;

  Duration get assistTimer => _assistTimer;

  Duration get bonusTimer => _bonusTimer;

  TimeOfDay get endAt => _endAt;

  // ============= Time setter ==============
  void setMainTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _mainTimer = Duration(hours: timeFromPicker!.hour, minutes: timeFromPicker.minute, seconds: 0);
    } else {
      _mainTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
    }
    notifyListeners();
  }

  void setAssistTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _assistTimer = Duration(hours: timeFromPicker!.hour, minutes: timeFromPicker.minute, seconds: 0);
    } else {
      _assistTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
    }
    notifyListeners();
  }

  void setBonusTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _bonusTimer = Duration(hours: timeFromPicker!.hour, minutes: timeFromPicker.minute, seconds: 0);
    } else {
      _bonusTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
    }
    notifyListeners();
  }

  // ============= Timer manager module  =============
  void decrementMainTimer() async {
    _mainTimer = const Duration(seconds: -1);
  }

  void decrementAssistTimer() async {
    _assistTimer -= const Duration(seconds: -1);
  }

  void decrementBonusTimer() async {
    _bonusTimer -= const Duration(seconds: -1);
  }

  void makeEndAt() async {
    Duration now = Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);
    int newHour, newMinute;

    // TODO: fix this (might be) buggy prevent clock overflow logic
    //set nre hour
    newHour = now.inHours + _mainTimer.inHours;
    if (newHour >= 24) {
      newHour -= 24;
    }

    //set new minute
    newMinute = now.inMinutes.remainder(60) + _mainTimer.inMinutes.remainder(60);
    if (newMinute >= 60) {
      newMinute -= 60;
      newHour += 1;
    }

    _endAt = TimeOfDay(hour: newHour, minute: newMinute);
  }

  // ========== Timer manager ===========
  void startTimer() async {
    _isRunning = true;
    startCountdown();
  }

  void pauseTimer() async {
    _isRunning = false;
  }

  void stopAndResetTimer() {
    _isRunning = false;
    setMainTimer(reset: true);
    setAssistTimer(reset: true);
    setBonusTimer(reset: true);
    notifyListeners();
  }

  void startCountdown() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning && _mainTimer.inSeconds > 0) {
        decrementMainTimer();
        decrementAssistTimer();
        decrementBonusTimer();
      } else if (!_isRunning && _mainTimer.inSeconds > 0) {
        timer.cancel();
      } else {
        stopAndResetTimer();
      }
    });
  }
}
