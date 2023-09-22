import 'dart:async';

import 'package:flutter/material.dart';

class TimerManager extends ChangeNotifier {
  Color _currentAccent = Colors.blue;
  Duration _displayTimer = const Duration(seconds: 0); // for displaying the countdown
  Duration _duration = const Duration(seconds: 0); // for duration between start and end of countdown
  Duration _endAt = const Duration(seconds: 0); // for the time where countdown ends
  Duration _assistTimer = const Duration(seconds: 0); // for the time where people can ask
  bool _timerIsRunning = false;
  String _title = "";

  Color get currentAccent => _currentAccent;

  Duration get displayTimer => _displayTimer;

  Duration get duration => _duration;

  Duration get endAt => _endAt;

  Duration get assistTimer => _assistTimer;

  bool get timerIsRunning => _timerIsRunning;

  String get title => _title;

  void setEndTimer(TimeOfDay? newEndTimer) {
    _endAt = Duration(hours: newEndTimer!.hour, minutes: newEndTimer.minute, seconds: 0);
    print("End hour: ${_endAt.inHours}, End minute: ${_endAt.inMinutes.remainder(60)}");
    notifyListeners();
  }

  void setAssistTimer(Duration newAssistTimer) {
    _assistTimer = newAssistTimer;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void toggleTimer() {
    if (_timerIsRunning) {
      _timerIsRunning = false;
    } else {
      _timerIsRunning = true;
      _duration = _endAt - Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second);
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
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.1) {
      _currentAccent = Colors.red;
      notifyListeners();
      return;
    }
  }

  void timerCounterdown() async {
    print("Timer started");

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerIsRunning && _displayTimer.inSeconds >= 0) {
        _displayTimer = _endAt - Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second);
        changeAccent();
        notifyListeners();
      } else {
        _displayTimer = const Duration(seconds: 0);
        timer.cancel();
        notifyListeners();
      }
    });
  }
}
