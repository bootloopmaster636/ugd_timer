import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/overlay.dart';
import 'package:ugd_timer/screen/background.dart';
import 'package:ugd_timer/screen/overlay/settingsOverlay.dart';
import 'package:ugd_timer/screen/top.dart';

class ScreenStackManager extends ConsumerWidget {
  const ScreenStackManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSettingsOverlayOpen = ref.watch(overlayStateLogicProvider).isTimerSettingsShown;
    return Stack(
      children: <Widget>[
        const Background(),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuint,
          opacity: isSettingsOverlayOpen ? 0.6 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuint,
            transform: Matrix4.translationValues(
              isSettingsOverlayOpen ? 80 : 0,
              0,
              0,
            ),
            height: 100.h - titleBarHeight,
            alignment: Alignment.center,
            child: const TopLayer(),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuint,
          transform: Matrix4.translationValues(
            isSettingsOverlayOpen ? 0 : -400,
            0,
            0,
          ),
          alignment: Alignment.centerLeft,
          child: const SettingsOverlay(),
        )
      ],
    );
  }
}
