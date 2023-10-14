import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ugd_timer/logic/managers/DisplayManager.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:ugd_timer/logic/managers/NotificationManager.dart';
import 'package:ugd_timer/logic/managers/TimerManager.dart';
import 'package:ugd_timer/logic/managers/ProfileManager.dart';
import 'dart:io';

class TimerState extends ChangeNotifier {
  // ============= Instances =============
  final ProfileManager _profileManager = ProfileManager();
  TimerManager _timerManager = TimerManager();
  DisplayManager _displayManager =
      DisplayManager("", Colors.lightBlue, ThemeMode.system);
  NotificationManager _notificationManager = NotificationManager();
  late PausableTimer timer = PausableTimer(const Duration(seconds: 1), () {});

  // ============= Variables =============
  bool _isAutoStartEnabled = false;
  TimeOfDay _autoStartTime = const TimeOfDay(hour: 0, minute: 0);

  bool _isRunning = false;
  bool _isSet = false;
  bool _isCutOff = false;
  bool _isCutOffRunning = false;
  bool _isAssistAvailableSoundPlayed = false;
  bool _isAllTimerFinishedSoundPlayed = false;

// ============== Getters =============
  bool get isAutoStartEnabled => _isAutoStartEnabled;

  bool get isRunning => _isRunning;

  bool get isCutOffRunning => _isCutOffRunning;

  bool get isSet => _isSet;

  NotificationManager get notificationManager => _notificationManager;

  TimerManager get timerManager => _timerManager;

  DisplayManager get displayManager => _displayManager;

  TimeOfDay get autoStartTime => _autoStartTime;

  // ============= Timer Manager Wrapper =============
  void setTimer(TimerType timerType, TimeOfDay? timeFromPicker) {
    _timerManager.setTimerFromPicker(timerType, timeFromPicker);
    notifyListeners();
  }

  void setStartAt(TimeOfDay? timeFromPicker) {
    _autoStartTime = timeFromPicker!;
    notifyListeners();
  }

  // ========== Timer Control ===========
  void startTimer() async {
    if (!_timerManager.isTimerSet(TimerType.main)) {
      return;
    }

    //TODO add timer autostart

    _isRunning = true;

    // if timer is already set, then just resume it.
    if (_isSet) {
      _timerManager.makeEndAt();

      timer.start();
    } else {
      // if timer is not set, then set it and start the countdown.
      _isSet = true;

      if (_timerManager.isTimerSet(TimerType.cutoff)) {
        _isCutOff = true;
      }

      startCountdown();
    }
  }

  void pauseTimer() async {
    _isRunning = false;
    timer.pause();
  }

  void toggleTimer() async {
    if (_isRunning) {
      pauseTimer();
    } else {
      startTimer();
    }

    notifyListeners();
  }

  void toggleAutoStart() async {
    _isAutoStartEnabled = !_isAutoStartEnabled;
    notifyListeners();
  }

  void stopAndResetTimer({bool isPressed = false}) {
    timer.cancel();

    if (isPressed) {
      _timerManager.setEndAt(const TimeOfDay(hour: 0, minute: 0));
      _displayManager.dynamicAccentChanger(
          _timerManager.getTimer(TimerType.main),
          _timerManager.getTimer(TimerType.mainFreeze));
    }

    _isRunning = false;
    _isSet = false;
    _isCutOff = false;
    _isCutOffRunning = false;

    _timerManager.resetTimers();
    _displayManager.setTitle("");
    _notificationManager.resetAllNotification();

    _isAssistAvailableSoundPlayed = false;
    _isAllTimerFinishedSoundPlayed = false;

    notifyListeners();
  }

  void checkAutoStart() async {
    timer = PausableTimer(const Duration(seconds: 1), () {
      if(_isAutoStartEnabled && DateTime.now().hour <= _autoStartTime.hour && DateTime.now().minute <= _autoStartTime.minute){
        _isAutoStartEnabled = false;
        timer..reset()..cancel();
      }
    })..start();
  }

  void startCountdown() async {
    _timerManager.makeEndAt();

    timer = PausableTimer(
      const Duration(seconds: 1),
      () {
        if (_isRunning && _timerManager.isTimerSet(TimerType.main)) {
          if (!_isCutOffRunning) {
            _displayManager.dynamicAccentChanger(
                _timerManager.getTimer(TimerType.main),
                _timerManager.getTimer(TimerType.mainFreeze));
          }

          _timerManager.decrementTimer(TimerType.main);
          _timerManager.decrementTimer(TimerType.assist);
          _timerManager.decrementTimer(TimerType.bonus);

          // to play sound when assistant becomes available
          if (!_timerManager.isTimerSet(TimerType.assist) &&
              !_isAssistAvailableSoundPlayed) {
            _notificationManager
                .playNotification(NotificationType.assistAvailable);
            _isAssistAvailableSoundPlayed = true;
          }

          // To continously repeat this timer till end. Do not code underneath this line.
          timer
            ..reset()
            ..start();
        } else if (_isCutOff) {
          _timerManager.addCutOfftoMain();
          _timerManager.setTimerDuration(TimerType.cutoff, Duration.zero);

          _displayManager.accentCutOff();

          //to play sound when cutoff timer starts
          _notificationManager.playNotification(NotificationType.cutoffStarted);
          _timerManager.makeEndAt();
          _isCutOff = false;
          _isCutOffRunning = true;

          timer
            ..reset()
            ..start();
        } else {
          if (!_isAllTimerFinishedSoundPlayed) {
            _notificationManager
                .playNotification(NotificationType.allTimerFinished);
            _isAllTimerFinishedSoundPlayed = true;
          }
          stopAndResetTimer();
        }
        notifyListeners();
      },
    )..start();
  }

  // ============= App config interface =============
  void setTitle(String s) {
    _displayManager.setTitle(s);
    notifyListeners();
  }

  String getTitle() {
    return _displayManager.title;
  }

  void changeThemeMode(String s) {
    _displayManager.changeThemeMode(s);
    notifyListeners();
  }

  // ============= Sound notifs =============
  void toggleSoundAvailable(NotificationType notificationType) {
    _notificationManager.toggleNotificationState(notificationType);
    notifyListeners();
  }

  void setSoundPath(NotificationType notificationType, File path) {
    _notificationManager.setNotificationSoundPath(notificationType, path);
    notifyListeners();
  }

  // ============= Profile Manager =============

  void exportProfile(String? path) {
    _profileManager.exportSettings(
        path, _displayManager, _timerManager, _notificationManager);
  }

  void importProfile(String? path) {
    _profileManager.importSettings(path);

    _displayManager = _profileManager.displayManager;
    _timerManager = _profileManager.timerManager;
    _notificationManager = _profileManager.notificationManager;

    notifyListeners();
  }
}
