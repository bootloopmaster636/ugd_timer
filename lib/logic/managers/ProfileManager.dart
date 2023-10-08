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

  void exportSettings(String? path, DisplayManager dManager,
      TimerManager tManager, NotificationManager nManager) {
    String theme;

    switch (dManager.currentThemeMode) {
      case ThemeMode.light:
        theme = "Light";
        break;

      case ThemeMode.dark:
        theme = "Dark";
        break;

      default:
        theme = "System";
        break;
    }

    String settings = "Title: ${dManager.title}\n"
        "Theme: $theme\n"
        "Main Timer: ${tManager.getTimer(TimerType.main).inSeconds}\n"
        "Assist Timer: ${tManager.getTimer(TimerType.assist).inSeconds}\n"
        "Bonus Timer: ${tManager.getTimer(TimerType.bonus).inSeconds}\n"
        "Cutoff Timer: ${tManager.getTimer(TimerType.cutoff).inSeconds}\n"
        "Assist Available Sound Enabled: ${nManager.getNotificationState(NotificationType.assistAvailable)}\n"
        "Assist Available Sound: ${nManager.getNotificationSoundPath(NotificationType.assistAvailable).path}\n"
        "Cutoff Started Sound Enabled: ${nManager.getNotificationState(NotificationType.cutoffStarted)}\n"
        "Cutoff Started Sound: ${nManager.getNotificationSoundPath(NotificationType.cutoffStarted).path}\n"
        "All Timer Finished Sound Enabled: ${nManager.getNotificationState(NotificationType.allTimerFinished)}\n"
        "All Timer Finished Sound: ${nManager.getNotificationSoundPath(NotificationType.allTimerFinished).path}\n";

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

        final Map<TimerType, int> timers = {
          TimerType.main: mainTimer,
          TimerType.mainFreeze: mainTimer,
          TimerType.assist: int.tryParse(settings[3].split(": ")[1]) ?? 0,
          TimerType.bonus: int.tryParse(settings[4].split(": ")[1]) ?? 0,
          TimerType.cutoff: int.tryParse(settings[5].split(": ")[1]) ?? 0,
        };

        final Map<NotificationType, bool> notifState = {
          NotificationType.assistAvailable:
              bool.tryParse(settings[6].split(": ")[1].trim()) ?? false,
          NotificationType.cutoffStarted:
              bool.tryParse(settings[8].split(": ")[1]) ?? false,
          NotificationType.allTimerFinished:
              bool.tryParse(settings[10].split(": ")[1]) ?? false,
        };

        final Map<NotificationType, String> notifFilePath = {
          NotificationType.assistAvailable: settings[7].split(": ")[1].trim(),
          NotificationType.cutoffStarted: settings[9].split(": ")[1].trim(),
          NotificationType.allTimerFinished: settings[11].split(": ")[1].trim(),
        };

        _displayManager.setTitle(title);
        _displayManager.changeThemeMode(settings[1].split(": ")[1].trim());

        timers.forEach((key, value) {
          _timerManager.setTimerDuration(key, Duration(seconds: value));
        });

        notifState.forEach((key, value) {
          _notificationManager.setNotificationState(key, value);
        });

        notifFilePath.forEach((key, value) {
          _notificationManager.setNotificationSoundPath(key, File(value));
        });
      } else {
        throw ("Invalid settings format. Not enough settings found.");
      }
    } catch (e) {
      throw ("Error reading or parsing settings: $e");
    }
  }
}
