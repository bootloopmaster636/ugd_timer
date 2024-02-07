import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugd_timer/screen/top/clockDisplay.dart';

part 'navigation.freezed.dart';
part 'navigation.g.dart';

@freezed
class TopWidget with _$TopWidget {
  factory TopWidget({
    Widget? currentlyShown,
  }) = _TopWidget;
}

@riverpod
class TopWidgetLogic extends _$TopWidgetLogic {
  // TODO(bootloopmaster636): will have to fix animation sometime, because the screen switching is 🤮

  @override
  TopWidget build() {
    return TopWidget(
      currentlyShown: const MainTimer().animate().fadeIn(),
    );
  }

  void backToTimer() {
    state = state.copyWith(currentlyShown: MainTimer().animate().fadeIn());
  }

  void setCurrentlyShown(Widget widget) {
    state = state.copyWith(currentlyShown: widget.animate().fadeIn());
  }
}
