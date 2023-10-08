import 'package:flutter/material.dart';

class DisplayManager {
  DisplayManager(this._title, this._currentAccent, this._currentThemeMode);

  String _title = "";
  Color _currentAccent = Colors.lightBlue;
  ThemeMode _currentThemeMode = ThemeMode.system;

  String get title => _title;

  Color get currentAccent => _currentAccent;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void setTitle(String title) {
    _title = title;
  }

  void accentCutOff() {
    _currentAccent = Colors.amber;
  }

  void dynamicAccentChanger(
      Duration currentTimerState, Duration freezedTimerState) {
    if (currentTimerState.inSeconds <= freezedTimerState.inSeconds * 0.2) {
      _currentAccent = Colors.red;
    } else if (currentTimerState.inSeconds <=
        freezedTimerState.inSeconds * 0.3) {
      _currentAccent = Colors.deepOrange;
    } else if (currentTimerState.inSeconds <=
        freezedTimerState.inSeconds * 0.4) {
      _currentAccent = Colors.orange;
    } else if (currentTimerState.inSeconds <=
        freezedTimerState.inSeconds * 0.5) {
      _currentAccent = Colors.lightGreen;
    } else if (currentTimerState.inSeconds <=
        freezedTimerState.inSeconds * 0.6) {
      _currentAccent = Colors.green;
    } else if (currentTimerState.inSeconds <=
        freezedTimerState.inSeconds * 0.7) {
      _currentAccent = Colors.teal;
    } else if (currentTimerState.inSeconds <=
        freezedTimerState.inSeconds * 0.8) {
      _currentAccent = Colors.cyan;
    } else {
      _currentAccent = Colors.lightBlue;
    }
  }

  void changeThemeMode(String theme) {
    if (theme == "Light") {
      _currentThemeMode = ThemeMode.light;
      return;
    }

    if (theme == "Dark") {
      _currentThemeMode = ThemeMode.dark;
      return;
    }
    _currentThemeMode = ThemeMode.system;
  }
}
