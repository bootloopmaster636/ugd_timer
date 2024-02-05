import 'package:fluent_ui/fluent_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h - titleBarHeight,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Acrylic(),
          // this is very expensive effect
          // CSSFilter.apply(
          //   value: CSSFilterMatrix()
          //       .grayscale(1)
          //       .brightness(FluentTheme.of(context).brightness == Brightness.light ? 3 : 1.5),
          //   child: Lottie.asset(
          //     'assets/lottie/bg-bubble.json',
          //     repeat: true,
          //     reverse: true,
          //     frameRate: const FrameRate(24),
          //     fit: BoxFit.cover,
          //     filterQuality: FilterQuality.none,
          //   ),
          // ),
          // Container(
          //   color: FluentTheme.of(context).accentColor.withOpacity(0.3),
          // ),
        ],
      ),
    );
  }
}
