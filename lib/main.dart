import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:override_text_scale_factor/override_text_scale_factor.dart';
import 'logic/displayState.dart';
import 'logic/mainLogic.dart';

import 'displayLayers/BottomLayer.dart';
import 'displayLayers/TopLayer.dart';
import 'displayLayers/OverlayLayer.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final timerProvider = ChangeNotifierProvider((ref) => TimerController());
final displayStateProvider = ChangeNotifierProvider((ref) => DisplayState());

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Timer UGD',
      theme: ThemeData(
        colorSchemeSeed: ref.watch(timerProvider).dispEtc.currentAccent,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: ref.watch(timerProvider).dispEtc.currentAccent,
        useMaterial3: true,
      ),
      themeMode: ref.watch(timerProvider).dispEtc.currentThemeMode,
      home: const Screen(),
    );
  }
}

class Screen extends ConsumerWidget {
  const Screen({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          const BottomLayer(),
          OverrideTextScaleFactor(textScaleFactor: ref.watch(displayStateProvider).displayFontScale, child: const TopLayer()),
          const OverlayLayer(),
        ],
      ),
    );
  }
}
