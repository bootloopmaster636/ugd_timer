import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd_timer/logic.dart';
import 'package:ugd_timer/settings.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final TimerProvider = ChangeNotifierProvider((ref) => TimerManager());

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Timer UGD',
      theme: ThemeData(
        colorSchemeSeed: ref.watch(TimerProvider).currentAccent,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: ref.watch(TimerProvider).currentAccent,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimateGradient(
            primaryColors: [Theme.of(context).colorScheme.secondaryContainer, Theme.of(context).colorScheme.tertiaryContainer],
            secondaryColors: [Theme.of(context).colorScheme.tertiaryContainer, Theme.of(context).colorScheme.secondaryContainer],
            primaryBegin: Alignment.topRight,
            primaryEnd: Alignment.bottomRight,
            secondaryBegin: Alignment.bottomLeft,
            secondaryEnd: Alignment.topRight,
            duration: const Duration(milliseconds: 5000),
          ),
          Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.fromLTRB(40, MediaQuery.of(context).size.height * 0.08, 40, 0),
                  constraints: const BoxConstraints(maxWidth: 768),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [BoxShadow(color: Color.fromARGB(30, 0, 40, 80), blurRadius: 8, offset: Offset(0, 4))]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ref.watch(TimerProvider).title.toUpperCase(),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Text(
                        "${ref.watch(TimerProvider).displayTimer.inHours.toString().padLeft(2, '0')} : "
                        "${ref.watch(TimerProvider).displayTimer.inMinutes.remainder(60).toString().padLeft(2, '0')} : "
                        "${ref.watch(TimerProvider).displayTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(FontAwesomeIcons.upload),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "${ref.watch(TimerProvider).endAt.inHours.toString().padLeft(2, '0')} : "
                                "${ref.watch(TimerProvider).endAt.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                                style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () => ref.read(TimerProvider).toggleTimer(),
                            child: const Text("Start/Freeze"),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          OutlinedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView())),
                            child: const Text("Settings"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 768),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.person,
                        size: 64,
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Dapat bertanya asisten?\n",
                          style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer, fontSize: 20),
                          children: const [
                            TextSpan(text: "XX menit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
