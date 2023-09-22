import 'dart:async';

import 'package:flutter/material.dart';

class TimerManager extends ChangeNotifier {
  Color _currentAccent = Colors.blue;
  final ThemeMode _currentThemeMode = ThemeMode.system;
  Duration _displayTimer =
      const Duration(seconds: 0); // for displaying the countdown
  Duration _duration = const Duration(
      seconds: 0); // for duration between start and end of countdown
  Duration _endAt =
      const Duration(seconds: 0); // for the time where countdown ends
  Duration _assistTimer =
      const Duration(seconds: 0); // for the time where people can ask
  bool _timerIsRunning = false;
  bool _isSet = false;

  String _title = "";

  Color get currentAccent => _currentAccent;

  ThemeMode get currentThemeMode => _currentThemeMode;

  Duration get displayTimer => _displayTimer;

  Duration get duration => _duration;

  Duration get endAt => _endAt;

  Duration get assistTimer => _assistTimer;

  bool get timerIsRunning => _timerIsRunning;

  String get title => _title;

  void setDisplayTimer(TimeOfDay? newDisplayTimer) {
    _displayTimer = Duration(
      hours: newDisplayTimer!.hour,
      minutes: newDisplayTimer.minute,
      seconds: 0,
    );
    notifyListeners();
  }

  void setEndTimer(Duration newEndTimer) {
    _endAt = newEndTimer +
        Duration(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second);

    print(
        "End hour: ${_endAt.inHours}, End minute: ${_endAt.inMinutes.remainder(60)}");
    notifyListeners();
  }

  void setAssistTimer(TimeOfDay? newAssistTimer) {
    _assistTimer = Duration(
        hours: newAssistTimer!.hour,
        minutes: newAssistTimer.minute,
        seconds: 0);
    _isSet = true;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void toggleTimer() {
    if (_displayTimer.inSeconds == 0) {
      return;
    }

    if (_timerIsRunning) {
      _timerIsRunning = false;
    } else {
      _timerIsRunning = true;
      _duration = _endAt -
          Duration(
              hours: DateTime.now().hour,
              minutes: DateTime.now().minute,
              seconds: DateTime.now().second);
      timerCounterdown();
    }
  }

  void changeAccent() async {
    if (_displayTimer.inSeconds >= _duration.inSeconds * 0.8) {
      _currentAccent = Colors.blue;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.6) {
      _currentAccent = Colors.cyan;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.4) {
      _currentAccent = Colors.green;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.3) {
      _currentAccent = Colors.yellow;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.2) {
      _currentAccent = Colors.orange;
      notifyListeners();
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.1) {
      _currentAccent = Colors.red;
      notifyListeners();
      return;
    }
  }

  void timerCounterdown() async {
    print("Timer started");

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_displayTimer == const Duration(seconds: 0) || !_timerIsRunning) {
        _displayTimer = const Duration(seconds: 0);
        _assistTimer = const Duration(seconds: 0);
        _endAt = const Duration(seconds: 0);
        _isSet = false;

        timer.cancel();
        notifyListeners();

        return;
      }

      if (_timerIsRunning) {
        _displayTimer = _displayTimer - const Duration(seconds: 1);
        _assistTimer -=
            _isSet ? const Duration(seconds: 1) : const Duration(seconds: 0);

        changeAccent();
        notifyListeners();
      }
    });
  }
}
