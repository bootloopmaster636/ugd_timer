import 'package:css_filter/css_filter.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h - titleBarHeight,

      // TODO(bootloopmaster636): add switch to disable the animation, to conserve power/improve performance
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Acrylic(),
          CSSFilter.apply(
            value: CSSFilterMatrix()
                .grayscale(1)
                .brightness(FluentTheme.of(context).brightness == Brightness.light ? 8 : 1),
            child: Lottie.asset(
              'assets/lottie/bg-geometry.json',
              repeat: true,
              renderCache: RenderCache.drawingCommands,
              fit: BoxFit.cover,
              addRepaintBoundary: true,
            ),
          ),
          Container(
            color: FluentTheme.of(context).accentColor.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
