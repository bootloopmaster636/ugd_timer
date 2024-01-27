import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timerEtc.freezed.dart';
part 'timerEtc.g.dart';

@freezed
class TimerEtc with _$TimerEtc {
  factory TimerEtc({
    required String title,
    required bool assistTimerEnabled,
    required bool bonusTimerEnabled,
    required String warningAudioPath,
    required String endAudioPath,
    required String startCutoffAudioPath,
  }) = _TimerEtc;
}

@riverpod
class TimerEtcLogic extends _$TimerEtcLogic {
  @override
  TimerEtc build() {
    return TimerEtc(
      title: '',
      assistTimerEnabled: false,
      bonusTimerEnabled: false,
      warningAudioPath: '',
      endAudioPath: '',
      startCutoffAudioPath: '',
    );
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setAssistTimerEnabled({required bool assistTimerEnabled}) {
    state = state.copyWith(assistTimerEnabled: assistTimerEnabled);
  }

  void setBonusTimerEnabled({required bool bonusTimerEnabled}) {
    state = state.copyWith(bonusTimerEnabled: bonusTimerEnabled);
  }

  void setWarningAudioPath(String warningAudioPath) {
    state = state.copyWith(warningAudioPath: warningAudioPath);
  }

  void setEndAudioPath(String endAudioPath) {
    state = state.copyWith(endAudioPath: endAudioPath);
  }

  void setStartCutoffAudioPath(String startCutoffAudioPath) {
    state = state.copyWith(startCutoffAudioPath: startCutoffAudioPath);
  }
}
