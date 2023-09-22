import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd_timer/logic.dart';
import 'package:ugd_timer/settings.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final timerProvider = ChangeNotifierProvider((ref) => TimerManager());

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Timer UGD',
      theme: ThemeData(
        colorSchemeSeed: ref.watch(timerProvider).currentAccent,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: ref.watch(timerProvider).currentAccent,
        useMaterial3: true,
      ),
      themeMode: ref.watch(timerProvider).currentThemeMode,
      home: const Home(),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [Background(), MainScreen()],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.tertiaryContainer,
          Theme.of(context).colorScheme.secondaryContainer,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            margin: EdgeInsets.fromLTRB(
                40, MediaQuery.of(context).size.height * 0.08, 40, 0),
            constraints: const BoxConstraints(maxWidth: 960),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(30, 0, 40, 80),
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ref.watch(timerProvider).title.toUpperCase(),
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 36,
                ),
                const DisplayTimer(),
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
                          "${ref.watch(timerProvider).endAt.inHours.toString().padLeft(2, '0')} : "
                          "${ref.watch(timerProvider).endAt.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
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
                      onPressed: () => ref.read(timerProvider).toggleTimer(),
                      child: Row(children: [
                        Icon(FontAwesomeIcons.play,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 16),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          FontAwesomeIcons.pause,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 16,
                        ),
                      ]),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsView())),
                      child: const Icon(FontAwesomeIcons.gear, size: 16),
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
                  size: 84,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                  text: TextSpan(
                    text: "Dapat bertanya asisten dalam\n",
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        fontSize: 28),
                    children: [
                      TextSpan(
                          text:
                              "${ref.watch(timerProvider).assistTimer.inMinutes.toString().padLeft(2, '0')} menit ${ref.watch(timerProvider).assistTimer.inSeconds.remainder(60).toString().padLeft(2, '0')} detik",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DisplayTimer extends ConsumerWidget {
  const DisplayTimer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     AnimatedFlipCounter(
    //       value: ref.watch(TimerProvider).displayTimer.inHours,
    //       prefix: (ref.watch(TimerProvider).displayTimer.inHours < 10) ? "0" : "",
    //     ),
    //   ],
    // );
    return Text(
      "${ref.watch(timerProvider).displayTimer.inHours.toString().padLeft(2, '0')} : "
      "${ref.watch(timerProvider).displayTimer.inMinutes.remainder(60).toString().padLeft(2, '0')} : "
      "${ref.watch(timerProvider).displayTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      overflow: TextOverflow.fade,
      maxLines: 1,
      style: const TextStyle(fontSize: 128, fontWeight: FontWeight.bold),
    );
  }
}
