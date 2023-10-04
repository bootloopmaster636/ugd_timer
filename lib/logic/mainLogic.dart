import 'package:flutter/material.dart';
import 'package:ugd_timer/logic/themeAndInfo.dart';
import 'package:pausable_timer/pausable_timer.dart';

class TimerController extends ChangeNotifier {
  bool _isRunning = false;
  bool _isSet = false;
  bool _isCutOff = false;
  bool _isCutOffRunning = false;
  Duration _mainTimerFreezed = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _mainTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _assistTimer = const Duration(minutes: 0, seconds: 0);
  Duration _bonusTimer = const Duration(minutes: 0, seconds: 0);
  Duration _cutOffTimer = const Duration(minutes: 0, seconds: 0);
  TimeOfDay _endAt = const TimeOfDay(hour: 0, minute: 0);
  final DisplayEtc _dispEtc =
      DisplayEtc("", Colors.lightBlue, ThemeMode.system);
  late PausableTimer timer = PausableTimer(const Duration(seconds: 1), () {});

// ============== Time getter =============
  bool get isRunning => _isRunning;

  Duration get mainTimerFreezed => _mainTimerFreezed;

  Duration get mainTimer => _mainTimer;

  Duration get assistTimer => _assistTimer;

  Duration get bonusTimer => _bonusTimer;

  Duration get cutOffTimer => _cutOffTimer;

  bool get isCutOffRunning => _isCutOffRunning;

  bool get isSet => _isSet;

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

    if (_isSet) {
      makeEndAt();
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

  void setCutOffTimer({TimeOfDay? timeFromPicker, bool? reset}) {
    if (reset == null || reset == false) {
      _cutOffTimer = Duration(
          hours: timeFromPicker!.hour,
          minutes: timeFromPicker.minute,
          seconds: 0);
    } else {
      _cutOffTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
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

      case "cutoff":
        if (_cutOffTimer.inSeconds > 0) {
          _cutOffTimer -= const Duration(seconds: 1);
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

    if (_isSet) {
      // if timer is already set, then just resume it.
      makeEndAt();
      timer.start();
    } else {
      // if timer is not set, then set it and start the countdown.
      _isSet = true;

      if (_cutOffTimer.inSeconds > 0) {
        _isCutOff = true;
      }

      startCountdown();
    }

    _isRunning = true;
    notifyListeners();
  }

  void pauseTimer() async {
    _isRunning = false;
    timer.pause();
    notifyListeners();
  }

  void toggleTimer() async {
    if (_isRunning) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  void stopAndResetTimer() {
    timer.cancel();
    _isRunning = false;
    _isSet = false;
    _isCutOff = false;
    _isCutOffRunning = false;
    setMainTimer(reset: true);
    setAssistTimer(reset: true);
    setBonusTimer(reset: true);
    setCutOffTimer(reset: true);
    notifyListeners();
  }

  void startCountdown() async {
    makeEndAt();

    timer = PausableTimer(
      const Duration(seconds: 1),
      () {
        if (_isRunning && _mainTimer.inSeconds > 0) {
          if (!_isCutOffRunning) {
            _dispEtc.dynamicAccentChanger(_mainTimer, _mainTimerFreezed);
          }

          decrementTimer("main");
          decrementTimer("assist");
          decrementTimer("bonus");

          // To continously repeat this timer till end.
          timer
            ..reset()
            ..start();
        } else if (_isCutOff) {
          _mainTimer += _cutOffTimer;
          _cutOffTimer = const Duration(minutes: 0, seconds: 0);

          _dispEtc.currentAccent = Colors.amber;

          makeEndAt();
          _isCutOff = false;
          _isCutOffRunning = true;
          timer
            ..reset()
            ..start();
        } else {
          stopAndResetTimer();
        }
        notifyListeners();
      },
    )..start();
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
