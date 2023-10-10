import 'package:flutter/material.dart';

class DisplayState extends ChangeNotifier {
  bool _settingsExpanded = false;
  double _displayFontScale = 1.0;

  bool get settingsExpanded => _settingsExpanded;
  double get displayFontScale => _displayFontScale;

  void toggleSettingsExpanded() {
    _settingsExpanded = !_settingsExpanded;
    notifyListeners();
  }

  void setDisplayFontScale(double scale) {
    _displayFontScale = scale;
    notifyListeners();
  }
}
