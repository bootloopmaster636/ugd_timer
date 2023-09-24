import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/logic/mainLogic.dart';
import 'package:ugd_timer/routes/settings.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

final timerProvider = ChangeNotifierProvider((ref) => TimerController());

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
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
        home: const Home(),
      );
    });
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
                  ref.watch(timerProvider).dispEtc.title.toUpperCase(),
                  style: TextStyle(fontSize: 5.h),
                ),
                SizedBox(
                  height: 4.h,
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
                          "${ref.watch(timerProvider).endAt.hour.toString().padLeft(2, '0')} : "
                          "${ref.watch(timerProvider).endAt.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontSize: 4.h, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          ref.read(timerProvider).stopAndResetTimer(),
                      child: const Icon(FontAwesomeIcons.stop, size: 16),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ref.watch(timerProvider).isRunning
                        ? FilledButton(
                            onPressed: () =>
                                ref.read(timerProvider).pauseTimer(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Icon(
                                FontAwesomeIcons.pause,
                                size: 16,
                              ),
                            ),
                          )
                        : FilledButton(
                            onPressed: () =>
                                ref.read(timerProvider).startTimer(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Icon(FontAwesomeIcons.play, size: 16),
                            ),
                          ),
                    const SizedBox(
                      width: 16,
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.personCircleQuestion,
                  size: 10.h,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(
                  width: 32,
                ),
                RichText(
                  text: TextSpan(
                    text: "Dapat bertanya asisten dalam\n",
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        fontSize: 2.8.h),
                    children: [
                      TextSpan(
                          text:
                              "${ref.watch(timerProvider).assistTimer.inMinutes.toString()} menit ${ref.watch(timerProvider).assistTimer.inSeconds.remainder(60).toString()} detik",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 4.h)),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 64,
                ),
                Icon(
                  FontAwesomeIcons.anglesUp,
                  size: 10.h,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                  text: TextSpan(
                    text: "Sisa waktu bonus\n",
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        fontSize: 2.8.h),
                    children: [
                      TextSpan(
                          text:
                              "${ref.watch(timerProvider).bonusTimer.inMinutes.toString()} menit ${ref.watch(timerProvider).bonusTimer.inSeconds.remainder(60).toString()} detik",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 4.h)),
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
      "${ref.watch(timerProvider).mainTimer.inHours.toString().padLeft(2, '0')} : "
      "${ref.watch(timerProvider).mainTimer.inMinutes.remainder(60).toString().padLeft(2, '0')} : "
      "${ref.watch(timerProvider).mainTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}",
      overflow: TextOverflow.fade,
      maxLines: 1,
      style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold),
    );
  }
}
