import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnimatedClockWidget extends HookConsumerWidget {
  const AnimatedClockWidget({required this.time, super.key});

  final Duration time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedFlipCounter(
          value: time.inHours,
          wholeDigits: 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
          textStyle: TextStyle(fontFamily: GoogleFonts.azeretMono().fontFamily, fontSize: 12),
        ),
        Text(
          ':',
          style: TextStyle(fontFamily: GoogleFonts.azeretMono().fontFamily, fontSize: 12),
        ),
        AnimatedFlipCounter(
          value: time.inMinutes % 60,
          wholeDigits: 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
          textStyle: TextStyle(fontFamily: GoogleFonts.azeretMono().fontFamily, fontSize: 12),
        ),
        Text(
          ':',
          style: TextStyle(fontFamily: GoogleFonts.azeretMono().fontFamily, fontSize: 12),
        ),
        AnimatedFlipCounter(
          value: time.inSeconds % 60,
          wholeDigits: 2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
          textStyle: TextStyle(fontFamily: GoogleFonts.azeretMono().fontFamily, fontSize: 12),
        ),
      ],
    );
  }
}
