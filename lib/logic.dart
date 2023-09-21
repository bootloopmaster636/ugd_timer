import 'package:flutter/material.dart';

class TimerManager extends ChangeNotifier {
  Color _currentAccent = Colors.blue;
  Duration _displayTimer = Duration(minutes: 0); // for displaying the countdown
  Duration _endAt = Duration(minutes: 0); // for the time where countdown ends
  Duration _assistTimer = Duration(minutes: 0); // for the time where people can ask
  bool _timerIsRunning = false;

  void setEndTimer(Duration newEndTimer) {
    _endAt = newEndTimer;
    notifyListeners();
  }

  void setAssistTimer(Duration newAssistTimer) {
    _assistTimer = newAssistTimer;
    notifyListeners();
  }

  void startTimer() {
    _timerIsRunning = true;
    notifyListeners();
  }

  void stopTimer() {
    _timerIsRunning = false;
    notifyListeners();
  }

  void timerCounterdown() async {
    _displayTimer = _endAt - Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute);

    while (_timerIsRunning) {
      if (_displayTimer.inSeconds > 0) {
        _displayTimer -= Duration(seconds: 1);
        notifyListeners();
      } else {
        _timerIsRunning = false;
        notifyListeners();
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
