import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keymap/keymap.dart';
import 'package:override_text_scale_factor/override_text_scale_factor.dart';
import 'logic/displayState.dart';
import 'logic/mainLogic.dart';
import 'logic/TimerManager.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

import 'displayLayers/BottomLayer.dart';
import 'displayLayers/TopLayer.dart';
import 'displayLayers/OverlayLayer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WindowManager.instance.setMinimumSize(const Size(1280, 720));
  }

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
        brightness: Brightness.light,
        colorSchemeSeed: ref.watch(timerProvider).dispEtc.currentAccent,
        useMaterial3: true,
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: ref.watch(timerProvider).dispEtc.currentAccent,
        useMaterial3: true,
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
      ),
      themeMode: ref.watch(timerProvider).dispEtc.currentThemeMode,
      home: const Screen(), //please dont "const" this... it'll bug the app
    );
  }
}

class GlobalKbShortcutManager extends ConsumerWidget {
  const GlobalKbShortcutManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeyboardWidget(
      bindings: [
        KeyAction(
          LogicalKeyboardKey.keyS,
          isControlPressed: true,
          'Open Settings Panel',
          () {
            ref.read(displayStateProvider).toggleSettingsExpanded();
          },
        ),
        KeyAction(
            LogicalKeyboardKey.keyR, isControlPressed: true, 'Reset Timer', () {
          if (ref
                  .read(timerProvider)
                  .timerManager
                  .getTimer(TimerType.main)
                  .inSeconds !=
              0) {
            ref.read(timerProvider).stopAndResetTimer(isPressed: true);
            showToast("Timer has been reset", context: context);
          } else {
            showToast(
              "Timer has not been initialized yet...",
              context: context,
            );
          }
        }),
        KeyAction(
          LogicalKeyboardKey.space,
          isControlPressed: true,
          "Toggle Timer",
          () {
            if (ref
                    .read(timerProvider)
                    .timerManager
                    .getTimer(TimerType.main)
                    .inSeconds !=
                0) {
              if (ref.read(timerProvider).isSet) {
                showToast(
                  "Timer has been ${ref.read(timerProvider).isRunning ? "paused" : "resumed"}",
                  context: context,
                );
              } else {
                showToast("Timer has been started", context: context);
              }

              ref.read(timerProvider).toggleTimer();
            } else {
              showToast(
                "Timer has not been initialized yet...",
                context: context,
              );
            }
          },
        )
      ],
      child: OverrideTextScaleFactor(
          textScaleFactor: ref.watch(displayStateProvider).displayFontScale,
          child: const TopLayer()),
    );
  }
}

class Screen extends ConsumerWidget {
  const Screen({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    return const Scaffold(
      body: Stack(
        children: [
          BottomLayer(),
          GlobalKbShortcutManager(),
          OverlayLayer(),
        ],
      ),
    );
  }
}
