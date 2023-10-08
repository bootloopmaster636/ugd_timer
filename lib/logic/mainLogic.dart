import 'package:flutter/material.dart';
import 'package:ugd_timer/logic/themeAndInfo.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:ugd_timer/logic/soundNotifs.dart';
import 'dart:io';

import 'package:ugd_timer/logic/TimerManager.dart';

class TimerController extends ChangeNotifier {
  // ============= Variables =============
  bool _isRunning = false;
  bool _isSet = false;
  bool _isCutOff = false;
  bool _isCutOffRunning = false;
  bool _isAssistAvailableSoundPlayed = false;
  bool _isCutoffStartedSoundPlayed = false;
  bool _isAllTimerFinishedSoundPlayed = false;
  final TimerManager _timerManager = TimerManager();

  final DisplayEtc _dispEtc =
      DisplayEtc("", Colors.lightBlue, ThemeMode.system);
  final SoundNotifs _soundNotifs = SoundNotifs();
  late PausableTimer timer = PausableTimer(const Duration(seconds: 1), () {});

// ============== Getters =============
  bool get isRunning => _isRunning;
  bool get isCutOffRunning => _isCutOffRunning;
  bool get isSet => _isSet;
  TimerManager get timerManager => _timerManager;
  DisplayEtc get dispEtc => _dispEtc;
  SoundNotifs get soundNotifs => _soundNotifs;

  // ============= Timer Manager Wrapper =============
  void setTimer(TimerType timerType, TimeOfDay? timeFromPicker) {
    _timerManager.setTimerFromPicker(timerType, timeFromPicker);
    notifyListeners();
  }

  // ========== Timer Control ===========
  void startTimer() async {
    if (_timerManager.getTimer(TimerType.main).inSeconds == 0) {
      return;
    }

    // if timer is already set, then just resume it.
    if (_isSet) {
      _timerManager.makeEndAt();
      timer.start();
    } else {
      // if timer is not set, then set it and start the countdown.
      _isSet = true;

      if (_timerManager.getTimer(TimerType.cutoff).inSeconds > 0) {
        _isCutOff = true;
      }

      _isRunning = true;

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

  void stopAndResetTimer({bool isPressed = false}) {
    timer.cancel();

    if (isPressed) {
      _timerManager.setEndAt(const TimeOfDay(hour: 0, minute: 0));
      _dispEtc.dynamicAccentChanger(_timerManager.getTimer(TimerType.main),
          _timerManager.getTimer(TimerType.mainFreeze));
    }

    _isRunning = false;
    _isSet = false;
    _isCutOff = false;
    _isCutOffRunning = false;
    _timerManager.resetTimers();
    _isAssistAvailableSoundPlayed = false;
    _isCutoffStartedSoundPlayed = false;
    _isAllTimerFinishedSoundPlayed = false;
    notifyListeners();
  }

  void startCountdown() async {
    _timerManager.makeEndAt();

    timer = PausableTimer(
      const Duration(seconds: 1),
      () {
        if (_isRunning &&
            _timerManager.getTimer(TimerType.main).inSeconds > 0) {
          if (!_isCutOffRunning) {
            _dispEtc.dynamicAccentChanger(
                _timerManager.getTimer(TimerType.main),
                _timerManager.getTimer(TimerType.mainFreeze));
          }

          _timerManager.decrementTimer(TimerType.main);
          _timerManager.decrementTimer(TimerType.assist);
          _timerManager.decrementTimer(TimerType.bonus);

          // To continously repeat this timer till end.
          timer
            ..reset()
            ..start();

          // to play sound when assistant becomes available
          if (_timerManager.getTimer(TimerType.assist).inSeconds == 0 &&
              !_isAssistAvailableSoundPlayed) {
            _soundNotifs.playAssistAvailable();
            _isAssistAvailableSoundPlayed = true;
          }
        } else if (_isCutOff) {
          _timerManager.addCutOfftoMain();
          _dispEtc.accentCutOff();

          //to play sound when cutoff timer starts
          if (!_isCutoffStartedSoundPlayed) {
            _soundNotifs.playCutoffStarted();
            _isCutoffStartedSoundPlayed = true;
          }

          _timerManager.makeEndAt();
          _isCutOff = false;
          _isCutOffRunning = true;
          timer
            ..reset()
            ..start();
        } else {
          if (!_isAllTimerFinishedSoundPlayed) {
            _soundNotifs.playAllTimerFinished();
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
    _dispEtc.setTitle(s);
    notifyListeners();
  }

  String getTitle() {
    return _dispEtc.title;
  }

  void changeThemeMode(String s) {
    _dispEtc.changeThemeMode(s);
    notifyListeners();
  }

  // ============= Sound notifs =============
  void toggleAssistAvailable() {
    _soundNotifs.toggleAssistAvailable();
    notifyListeners();
  }

  void toggleCutoffStarted() {
    _soundNotifs.toggleCutoffStarted();
    notifyListeners();
  }

  void toggleAllTimerFinished() {
    _soundNotifs.toggleAllTimerFinished();
    notifyListeners();
  }

  void setAssistAvailableSoundPath(File path) {
    _soundNotifs.setAssistAvailableSoundPath(path);
    notifyListeners();
  }

  void setCutoffStartedSoundPath(File path) {
    _soundNotifs.setCutoffStartedSoundPath(path);
    notifyListeners();
  }

  void setAllTimerFinishedSoundPath(File path) {
    _soundNotifs.setAllTimerFinishedSoundPath(path);
    notifyListeners();
  }

  void exportSettings(String? path) {
    String settings = "Title: ${_dispEtc.title}\n"
        "Theme: ${_dispEtc.currentThemeMode}\n"
        "Main Timer: ${_timerManager.getTimer(TimerType.main).inSeconds}\n"
        "Assist Timer: ${_timerManager.getTimer(TimerType.assist).inSeconds}\n"
        "Bonus Timer: ${_timerManager.getTimer(TimerType.bonus).inSeconds}\n"
        "Cutoff Timer: ${_timerManager.getTimer(TimerType.cutoff).inSeconds}\n"
        "Assist Available Sound: ${_soundNotifs.assistAvailableSoundPath.path}\n"
        "Cutoff Started Sound: ${_soundNotifs.cutoffStartedSoundPath.path}\n"
        "All Timer Finished Sound: ${_soundNotifs.allTimerFinishedSoundPath.path}\n";

    File file = File(path!);
    file.writeAsString(settings);
  }

  void importSettings(String path) {
    File configFile = File(path);

    try {
      List<String> settings = configFile.readAsStringSync().split("\n");

      if (settings.length >= 9) {
        String title = settings[0].split(": ")[1].trim();
        int mainTimer = int.tryParse(settings[2].split(": ")[1]) ?? 0;
        int assistTimer = int.tryParse(settings[3].split(": ")[1]) ?? 0;
        int bonusTimer = int.tryParse(settings[4].split(": ")[1]) ?? 0;
        int cutoffTimer = int.tryParse(settings[5].split(": ")[1]) ?? 0;
        String assistAvailableSoundPath = settings[6].split(": ")[1].trim();
        String cutoffStartedSoundPath = settings[7].split(": ")[1].trim();
        String allTimerFinishedSoundPath = settings[8].split(": ")[1].trim();

        _dispEtc.setTitle(title);

        _timerManager.setTimerDuration(
            TimerType.main, Duration(seconds: mainTimer));
        _timerManager.setTimerDuration(
            TimerType.mainFreeze, Duration(seconds: mainTimer));
        _timerManager.setTimerDuration(
            TimerType.assist, Duration(seconds: assistTimer));
        _timerManager.setTimerDuration(
            TimerType.bonus, Duration(seconds: bonusTimer));
        _timerManager.setTimerDuration(
            TimerType.cutoff, Duration(seconds: cutoffTimer));

        _soundNotifs
            .setAssistAvailableSoundPath(File(assistAvailableSoundPath));
        _soundNotifs.setCutoffStartedSoundPath(File(cutoffStartedSoundPath));
        _soundNotifs
            .setAllTimerFinishedSoundPath(File(allTimerFinishedSoundPath));
        notifyListeners();
      } else {
        throw ("Invalid settings format. Not enough settings found.");
      }
    } catch (e) {
      throw ("Error reading or parsing settings: $e");
    }
  }
}
