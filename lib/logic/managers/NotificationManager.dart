import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

enum NotificationType { assistAvailable, cutoffStarted, allTimerFinished }

class NotificationManager {
  final Map<NotificationType, File> _notificationSettings = {
    NotificationType.assistAvailable: File(''),
    NotificationType.cutoffStarted: File(''),
    NotificationType.allTimerFinished: File(''),
  };

  final Map<NotificationType, bool> _notificationEnabled = {
    NotificationType.assistAvailable: false,
    NotificationType.cutoffStarted: false,
    NotificationType.allTimerFinished: false,
  };

  final AudioPlayer _player = AudioPlayer();

  void setNotificationSoundPath(NotificationType notificationType, File path) {
    _notificationSettings[notificationType] = path;
  }

  File getNotificationSoundPath(NotificationType notificationType) {
    return _notificationSettings[notificationType]!;
  }

  void setNotificationEnabled(NotificationType notificationType, bool value) {
    _notificationEnabled[notificationType] = value;
  }

  void toggleNotificationEnabled(NotificationType notificationType) {
    _notificationEnabled[notificationType] =
        !_notificationEnabled[notificationType]!;
  }

  bool getNotificationEnabled(NotificationType notificationType) {
    return _notificationEnabled[notificationType]!;
  }

  Future<void> playAssistAvailable() async {
    if (getNotificationEnabled(NotificationType.assistAvailable)) {
      await _player.play(DeviceFileSource(
          getNotificationSoundPath(NotificationType.assistAvailable).path));
    }
  }

  Future<void> playCutoffStarted() async {
    if (getNotificationEnabled(NotificationType.cutoffStarted)) {
      await _player.play(DeviceFileSource(
          getNotificationSoundPath(NotificationType.cutoffStarted).path));
    }
  }

  Future<void> playAllTimerFinished() async {
    if (getNotificationEnabled(NotificationType.allTimerFinished)) {
      await _player.play(DeviceFileSource(
          getNotificationSoundPath(NotificationType.allTimerFinished).path));
    }
  }
}
