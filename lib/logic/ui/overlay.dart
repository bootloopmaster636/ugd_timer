import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overlay.freezed.dart';
part 'overlay.g.dart';

@freezed
class OverlayState with _$OverlayState {
  factory OverlayState({
    required bool isTimerSettingsShown,
  }) = _OverlayState;
}

@riverpod
class OverlayStateLogic extends _$OverlayStateLogic {
  @override
  OverlayState build() {
    return OverlayState(isTimerSettingsShown: false);
  }

  void toggleTimerSettings() {
    state = state.copyWith(isTimerSettingsShown: !state.isTimerSettingsShown);
  }
}
