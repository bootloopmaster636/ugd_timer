import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/ui/accent_color.dart';

class Background extends ConsumerWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AccentColor accent = ref.watch(accentColorStateProvider).accentColor.toAccentColor();
    return SizedBox(
      width: 100.w,
      height: 100.h - titleBarHeight,

      // TODO(bootloopmaster636): add switch to disable the animation, to conserve power/improve performance
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ColoredBox(color: FluentTheme.of(context).menuColor),
          // CSSFilter.apply(
          //   value: CSSFilterMatrix()
          //       .saturate(0)
          //       .brightness(FluentTheme.of(context).brightness == Brightness.light ? 1.4 : 0.8),
          //   child: Lottie.asset(
          //     'assets/lottie/bg-geo.json',
          //     repeat: true,
          //     addRepaintBoundary: true,
          //     backgroundLoading: true,
          //     renderCache: RenderCache.drawingCommands,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            color: (FluentTheme.of(context).brightness == Brightness.light ? accent.lightest : accent.darker)
                .withOpacity(0.16),
          ),
        ],
      ),
    );
  }
}
