import 'package:flutter/material.dart';
import 'package:ugd_timer/logic/themeAndInfo.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:ugd_timer/logic/soundNotifs.dart';
import 'dart:io';

class TimerController extends ChangeNotifier {
  bool _isRunning = false;
  bool _isSet = false;
  bool _isCutOff = false;
  bool _isCutOffRunning = false;
  bool _isAssistAvailableSoundPlayed = false;
  bool _isCutoffStartedSoundPlayed = false;
  bool _isAllTimerFinishedSoundPlayed = false;
  Duration _mainTimerFreezed = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _mainTimer = const Duration(hours: 0, minutes: 0, seconds: 0);
  Duration _assistTimer = const Duration(minutes: 0, seconds: 0);
  Duration _bonusTimer = const Duration(minutes: 0, seconds: 0);
  Duration _cutOffTimer = const Duration(minutes: 0, seconds: 0);
  TimeOfDay _endAt = const TimeOfDay(hour: 0, minute: 0);
  final DisplayEtc _dispEtc =
      DisplayEtc("", Colors.lightBlue, ThemeMode.system);
  final SoundNotifs _soundNotifs = SoundNotifs();
  late PausableTimer timer = PausableTimer(const Duration(seconds: 1), () {});

// ============== Getters =============
  bool get isRunning => _isRunning;
  Duration get mainTimerFreezed => _mainTimerFreezed;
  Duration get mainTimer => _mainTimer;
  Duration get assistTimer => _assistTimer;
  Duration get bonusTimer => _bonusTimer;
  Duration get cutOffTimer => _cutOffTimer;
  bool get isCutOffRunning => _isCutOffRunning;
  bool get isSet => _isSet;
  DisplayEtc get dispEtc => _dispEtc;
  SoundNotifs get soundNotifs => _soundNotifs;
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

  void stopAndResetTimer({bool isPressed = false}) {
    timer.cancel();

    if (isPressed) {
      _endAt = const TimeOfDay(hour: 0, minute: 0);
    }

    _isRunning = false;
    _isSet = false;
    _isCutOff = false;
    _isCutOffRunning = false;
    setMainTimer(reset: true);
    setAssistTimer(reset: true);
    setBonusTimer(reset: true);
    setCutOffTimer(reset: true);

    _isAssistAvailableSoundPlayed = false;
    _isCutoffStartedSoundPlayed = false;
    _isAllTimerFinishedSoundPlayed = false;
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

          // to play sound when assistant becomes available
          if (_assistTimer.inSeconds == 0 && !_isAssistAvailableSoundPlayed) {
            _soundNotifs.playAssistAvailable();
            _isAssistAvailableSoundPlayed = true;
          }
        } else if (_isCutOff) {
          _mainTimer += _cutOffTimer;
          _cutOffTimer = const Duration(minutes: 0, seconds: 0);
          _dispEtc.accentCutOff();

          //to play sound when cutoff timer starts
          if (!_isCutoffStartedSoundPlayed) {
            _soundNotifs.playCutoffStarted();
            _isCutoffStartedSoundPlayed = true;
          }

          makeEndAt();
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
        "Main Timer: ${_mainTimer.inSeconds}\n"
        "Assist Timer: ${_assistTimer.inSeconds}\n"
        "Bonus Timer: ${_bonusTimer.inSeconds}\n"
        "Cutoff Timer: ${_cutOffTimer.inSeconds}\n"
        "Assist Available Sound: ${_soundNotifs.assistAvailableSoundPath.path}\n"
        "Cutoff Started Sound: ${_soundNotifs.cutoffStartedSoundPath.path}\n"
        "All Timer Finished Sound: ${_soundNotifs.allTimerFinishedSoundPath.path}\n";

    File file = File(path!);
    file.writeAsString(settings);
  }

  void importSettings(String path) {
    File configFile = File(path);
    List<String> settings = configFile.readAsStringSync().split("\n");

    String title = settings[0].split(": ")[1];
    int mainTimer = int.parse(settings[2].split(": ")[1]);
    int assistTimer = int.parse(settings[3].split(": ")[1]);
    int bonusTimer = int.parse(settings[4].split(": ")[1]);
    int cutoffTimer = int.parse(settings[5].split(": ")[1]);
    File assistAvailableSoundPath = File(settings[6].split(": ")[2]);
    File cutoffStartedSoundPath = File(settings[7].split(": ")[2]);
    File allTimerFinishedSoundPath = File(settings[8].split(": ")[2]);

    _dispEtc.setTitle(title);
    _dispEtc.accentCutOff();
    _mainTimer = Duration(seconds: mainTimer);
    _mainTimerFreezed = Duration(seconds: mainTimer);
    _assistTimer = Duration(seconds: assistTimer);
    _bonusTimer = Duration(seconds: bonusTimer);
    _cutOffTimer = Duration(seconds: cutoffTimer);
    _soundNotifs.setAssistAvailableSoundPath(assistAvailableSoundPath);
    _soundNotifs.setCutoffStartedSoundPath(cutoffStartedSoundPath);
    _soundNotifs.setAllTimerFinishedSoundPath(allTimerFinishedSoundPath);
    notifyListeners();
  }
}
