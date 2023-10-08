import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

enum NotificationType { assistAvailable, cutoffStarted, allTimerFinished }

class NotificationManager {
  final Map<NotificationType, File> _notificationSoundPath = {
    NotificationType.assistAvailable: File(''),
    NotificationType.cutoffStarted: File(''),
    NotificationType.allTimerFinished: File(''),
  };

  final Map<NotificationType, bool> _notificationState = {
    NotificationType.assistAvailable: false,
    NotificationType.cutoffStarted: false,
    NotificationType.allTimerFinished: false,
  };

  final AudioPlayer _player = AudioPlayer();

  void setNotificationSoundPath(NotificationType notificationType, File path) {
    _notificationSoundPath[notificationType] = path;
  }

  File getNotificationSoundPath(NotificationType notificationType) {
    return _notificationSoundPath[notificationType]!;
  }

  void setNotificationState(NotificationType notificationType, bool value) {
    _notificationState[notificationType] = value;
  }

  void toggleNotificationState(NotificationType notificationType) {
    _notificationState[notificationType] =
        !_notificationState[notificationType]!;
  }

  bool getNotificationState(NotificationType notificationType) {
    return _notificationState[notificationType]!;
  }

  Future<void> playAssistAvailable() async {
    if (getNotificationState(NotificationType.assistAvailable)) {
      await _player.play(DeviceFileSource(
          getNotificationSoundPath(NotificationType.assistAvailable).path));
    }
  }

  Future<void> playCutoffStarted() async {
    if (getNotificationState(NotificationType.cutoffStarted)) {
      await _player.play(DeviceFileSource(
          getNotificationSoundPath(NotificationType.cutoffStarted).path));
    }
  }

  Future<void> playAllTimerFinished() async {
    if (getNotificationState(NotificationType.allTimerFinished)) {
      await _player.play(DeviceFileSource(
          getNotificationSoundPath(NotificationType.allTimerFinished).path));
    }
  }
}
