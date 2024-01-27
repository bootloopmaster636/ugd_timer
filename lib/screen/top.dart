import 'package:fluent_ui/fluent_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/screen/top/timer.dart';

class TopLayer extends StatelessWidget {
  const TopLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 72.w,
              constraints: BoxConstraints(
                maxWidth: 120.h,
              ),
              child: const FittedBox(
                child: Timer(),
              ),
            ),
          ],
        );
      },
    );
  }
}
