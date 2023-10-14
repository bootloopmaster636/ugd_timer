import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class SoundNotifs {
  bool _assistAvailableEnabled = false;
  bool _cutoffStartedEnabled = false;
  bool _allTimerFinishedEnabled = false;

  File _assistAvailableSoundPath = File('');
  File _cutoffStartedSoundPath = File('');
  File _allTimerFinishedSoundPath = File('');

  final AudioPlayer _player = AudioPlayer();

  bool get assistAvailableEnabled => _assistAvailableEnabled;
  bool get cutoffStartedEnabled => _cutoffStartedEnabled;
  bool get allTimerFinishedEnabled => _allTimerFinishedEnabled;
  File get assistAvailableSoundPath => _assistAvailableSoundPath;
  File get cutoffStartedSoundPath => _cutoffStartedSoundPath;
  File get allTimerFinishedSoundPath => _allTimerFinishedSoundPath;

  void toggleAssistAvailable() {
    _assistAvailableEnabled = !_assistAvailableEnabled;
  }

  void toggleCutoffStarted() {
    _cutoffStartedEnabled = !_cutoffStartedEnabled;
  }

  void toggleAllTimerFinished() {
    _allTimerFinishedEnabled = !_allTimerFinishedEnabled;
  }

  void setAssistAvailableSoundPath(File path) {
    _assistAvailableSoundPath = path;
  }

  void setCutoffStartedSoundPath(File path) {
    _cutoffStartedSoundPath = path;
  }

  void setAllTimerFinishedSoundPath(File path) {
    _allTimerFinishedSoundPath = path;
  }

  Future<void> playAssistAvailable() async {
    if (_assistAvailableEnabled) {
      await _player.play(DeviceFileSource(_assistAvailableSoundPath.path));
    }
  }

  Future<void> playCutoffStarted() async {
    if (_cutoffStartedEnabled) {
      await _player.play(DeviceFileSource(_cutoffStartedSoundPath.path));
    }
  }

  Future<void> playAllTimerFinished() async {
    if (_allTimerFinishedEnabled) {
      await _player.play(DeviceFileSource(_allTimerFinishedSoundPath.path));
    }
  }
}