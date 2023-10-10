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

  void resetAllNotification() {
    _notificationSoundPath.forEach((key, value) {
      _notificationSoundPath[key] = File('');
    });

    _notificationState.forEach((key, value) {
      _notificationState[key] = false;
    });
  }

  Future<void> playNotification(NotificationType notificationType) async {
    if (getNotificationState(notificationType)) {
      await _player.play(
          DeviceFileSource(getNotificationSoundPath(notificationType).path));
    }
  }
}
