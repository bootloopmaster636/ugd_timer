import 'package:fluent_ui/fluent_ui.dart';
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

@freezed
class OverlayWidget with _$OverlayWidget {
  factory OverlayWidget({
    required Widget widget,
  }) = _OverlayWidget;
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

@riverpod
class OverlayWidgetLogic extends _$OverlayWidgetLogic {
  @override
  OverlayWidget build() {
    return OverlayWidget(widget: const SizedBox());
  }

  void setWidget(Widget widget) {
    final OverlayPortalController overlayCtl = OverlayPortalController();
    state = state.copyWith(
      widget: OverlayPortal(
        controller: overlayCtl,
        overlayChildBuilder: (BuildContext context) {
          return widget;
        },
      ),
    );
  }

  void clearWidget() {
    state = state.copyWith(widget: const SizedBox());
  }
}
