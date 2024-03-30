import 'package:fluent_ui/fluent_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';
import 'package:ugd_timer/screen/top/clock_display.dart';

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
  @override
  TopWidget build() {
    return TopWidget(
      currentlyShown: PlayAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeOutQuart,
        builder: (BuildContext context, double value, _) {
          return Opacity(
            opacity: value,
            child: const MainTimer(),
          );
        },
      ),
    );
  }

  void backToTimer() {
    state = state.copyWith(
      currentlyShown: PlayAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.05, end: 1),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuart,
        builder: (BuildContext context, double value, _) {
          return Transform.scale(
            scale: value,
            child: const MainTimer(),
          );
        },
      ),
    );
  }

  void setCurrentlyShown(Widget widget) {
    state = state.copyWith(
      currentlyShown: PlayAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.95, end: 1),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuart,
        builder: (BuildContext context, double value, _) {
          return Transform.scale(
            scale: value,
            child: widget,
          );
        },
        key: ValueKey<Widget>(widget),
      ),
    );
  }
}
