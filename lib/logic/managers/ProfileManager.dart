import 'package:flutter/material.dart';
import 'package:ugd_timer/logic/managers/NotificationManager.dart';
import 'package:ugd_timer/logic/managers/TimerManager.dart';
import 'package:ugd_timer/logic/managers/DisplayManager.dart';
import 'dart:io';

class ProfileManager {
  final TimerManager _timerManager = TimerManager();
  final DisplayManager _displayManager =
      DisplayManager("", Colors.lightBlue, ThemeMode.system);
  final NotificationManager _notificationManager = NotificationManager();

  TimerManager get timerManager => _timerManager;
  DisplayManager get displayManager => _displayManager;
  NotificationManager get notificationManager => _notificationManager;

  void exportSettings(String? path, DisplayManager _displayManager,
      TimerManager _timerManager, NotificationManager _notificationManager) {
    String settings = "Title: ${_displayManager.title}\n"
        "Theme: ${_displayManager.currentThemeMode}\n"
        "Main Timer: ${_timerManager.getTimer(TimerType.main).inSeconds}\n"
        "Assist Timer: ${_timerManager.getTimer(TimerType.assist).inSeconds}\n"
        "Bonus Timer: ${_timerManager.getTimer(TimerType.bonus).inSeconds}\n"
        "Cutoff Timer: ${_timerManager.getTimer(TimerType.cutoff).inSeconds}\n"
        "Assist Available Sound Enabled: ${_notificationManager.getNotificationEnabled(NotificationType.assistAvailable)}\n"
        "Assist Available Sound: ${_notificationManager.getNotificationSoundPath(NotificationType.assistAvailable).path}\n"
        "Cutoff Started Sound Enabled: ${_notificationManager.getNotificationEnabled(NotificationType.cutoffStarted)}\n"
        "Cutoff Started Sound: ${_notificationManager.getNotificationSoundPath(NotificationType.cutoffStarted).path}\n"
        "All Timer Finished Sound Enabled: ${_notificationManager.getNotificationEnabled(NotificationType.allTimerFinished)}\n"
        "All Timer Finished Sound: ${_notificationManager.getNotificationSoundPath(NotificationType.allTimerFinished).path}\n";

    File file = File(path!);
    file.writeAsString(settings);
  }

  void importSettings(String? path) {
    File configFile = File(path!);

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

        _displayManager.setTitle(title);

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

        assistAvailableSoundPath != ''
            ? _notificationManager.setNotificationEnabled(
                NotificationType.assistAvailable, true)
            : _notificationManager.setNotificationEnabled(
                NotificationType.assistAvailable, false);

        cutoffStartedSoundPath != ''
            ? _notificationManager.setNotificationEnabled(
                NotificationType.cutoffStarted, true)
            : _notificationManager.setNotificationEnabled(
                NotificationType.cutoffStarted, false);

        allTimerFinishedSoundPath != ''
            ? _notificationManager.setNotificationEnabled(
                NotificationType.allTimerFinished, true)
            : _notificationManager.setNotificationEnabled(
                NotificationType.allTimerFinished, false);

        _notificationManager.setNotificationSoundPath(
            NotificationType.assistAvailable, File(assistAvailableSoundPath));
        _notificationManager.setNotificationSoundPath(
            NotificationType.cutoffStarted, File(cutoffStartedSoundPath));
        _notificationManager.setNotificationSoundPath(
            NotificationType.allTimerFinished, File(allTimerFinishedSoundPath));
      } else {
        throw ("Invalid settings format. Not enough settings found.");
      }
    } catch (e) {
      throw ("Error reading or parsing settings: $e");
    }
  }
}
