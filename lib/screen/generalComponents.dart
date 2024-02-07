import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HideableWidget extends StatelessWidget {
  const HideableWidget({required this.isShown, required this.child, super.key});

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
        sizeCurve: Curves.easeOutExpo,
      ),
    );
  }
}

class HoverRevealer extends HookWidget {
  const HoverRevealer({this.height, this.width, this.decoration, this.padding, this.child, super.key});

  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isHovered = useState(false);
    return AnimatedOpacity(
      opacity: isHovered.value ? 1 : 0.6,
      duration: const Duration(milliseconds: 250),
      child: MouseRegion(
        onHover: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: Container(
          width: width,
          height: height,
          decoration: decoration,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
