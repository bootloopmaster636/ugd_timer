import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_conf.freezed.dart';
part 'timer_conf.g.dart';

@freezed
class TimerConf with _$TimerConf {
  factory TimerConf({
    required String title,
    required bool assistTimerEnabled,
    required bool bonusTimerEnabled,
    required String warningAudioPath,
    required String endAudioPath,
    required String startCutoffAudioPath,
  }) = _TimerConf;

  factory TimerConf.fromJson(Map<String, dynamic> json) => _$TimerConfFromJson(json);
}

@riverpod
class TimerConfLogic extends _$TimerConfLogic {
  @override
  TimerConf build() {
    return TimerConf(
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
