import 'package:fluent_ui/fluent_ui.dart';

class AnimatedSpawnableWidget extends StatelessWidget {
  const AnimatedSpawnableWidget({required this.isShown, required this.child, super.key});

  final bool isShown;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedCrossFade(
        firstChild: child,
        secondChild: const SizedBox(),
        crossFadeState: isShown ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 350),
        sizeCurve: Curves.easeOutQuart,
      ),
    );
  }
}
