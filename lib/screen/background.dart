import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h - 32,
      color: (defaultTargetPlatform == TargetPlatform.linux)
          ? FluentTheme.of(context).menuColor.withOpacity(0.8)
          : Colors.transparent,
    );
  }
}
