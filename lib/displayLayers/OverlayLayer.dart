import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd_timer/main.dart';
import 'package:url_launcher/url_launcher.dart';

class OverlayLayer extends ConsumerWidget {
  const OverlayLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayStateWatcher = ref.watch(displayStateProvider);
    return Animate(
      effects: const [
        SlideEffect(duration: Duration(milliseconds: 450), curve: Curves.easeOutCubic, begin: Offset(-1, 0), end: Offset(0, 0))
      ],
      target: (displayStateWatcher.settingsExpanded == true) ? 1 : 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: const SettingsPanelInside(),
        ),
      ),
    );
  }
}

class SettingsPanelInside extends ConsumerWidget {
  const SettingsPanelInside({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 400,
      height: MediaQuery.of(context).size.height,
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      color: Theme.of(context).colorScheme.background.withOpacity(0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(onPressed: () => ref.read(displayStateProvider).toggleSettingsExpanded(), child: const Icon(Icons.arrow_back)),
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: const [
                SectionTitle(title: "Timer Control"),
                TimerControlSection(),
                TitleSection(),
                SectionTitle(title: "Timer Durations"),
                MainTimerSection(),
                AssistTimerSection(),
                BonusTimerSection(),
                SectionTitle(title: "Display"),
                ThemeModeSection(),
                TextScaleFactorSection(),
                AboutUs(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerControlSection extends ConsumerWidget {
  const TimerControlSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: ListTile(
              title: const Text("Timer control"),
              subtitle: const Text("Start, pause, reset timer"),
              trailing: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (ref.watch(timerProvider).isRunning)
                      ? IconButton(
                          icon: const Icon(Icons.pause),
                          onPressed: () => ref.read(timerProvider).pauseTimer(),
                        )
                      : IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () => ref.read(timerProvider.notifier).startTimer(),
                        ),
                  IconButton(
                    icon: const Icon(Icons.replay),
                    onPressed: () => ref.read(timerProvider.notifier).stopAndResetTimer(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

TextEditingController _controller = TextEditingController();

class TitleSection extends ConsumerWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: const Text("Set timer title"),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TextField(
              decoration: const InputDecoration(),
              controller: _controller,
              onChanged: (value) {
                ref.read(timerProvider).setTitle(value);
                _controller.text = value;
              }),
        ),
      ),
    );
  }
}

class MainTimerSection extends ConsumerWidget {
  const MainTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: const Text("Main timer"),
        subtitle: const Text("Set the main timer duration"),
        trailing: Text(
          "${ref.watch(timerProvider).mainTimer.inMinutes} minutes",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () async => ref.read(timerProvider).setMainTimer(timeFromPicker: await ShowTimePickerDialog(context)),
      ),
    );
  }
}

class AssistTimerSection extends ConsumerWidget {
  const AssistTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: const Text("Assistant timer"),
        subtitle: const Text("Set the duration where student can ask for help"),
        trailing: Text(
          "${ref.watch(timerProvider).assistTimer.inMinutes} minutes",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () async => ref.read(timerProvider).setAssistTimer(timeFromPicker: await ShowTimePickerDialog(context)),
      ),
    );
  }
}

class BonusTimerSection extends ConsumerWidget {
  const BonusTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: const Text("Bonus timer"),
        subtitle: const Text("Submission must be made before this timer ends"),
        trailing: Text(
          "${ref.watch(timerProvider).bonusTimer.inMinutes} minutes",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () async => ref.read(timerProvider).setBonusTimer(timeFromPicker: await ShowTimePickerDialog(context)),
      ),
    );
  }
}

class TextScaleFactorSection extends ConsumerWidget {
  const TextScaleFactorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
          title: const Text("Text scale factor"),
          subtitle: Slider(
            value: ref.watch(displayStateProvider).displayFontScale,
            min: 0.8,
            max: 1.5,
            divisions: 8,
            onChanged: (value) => ref.read(displayStateProvider).setDisplayFontScale(value),
          ),
          trailing: Text(
            ref.watch(displayStateProvider).displayFontScale.toStringAsFixed(1),
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}

class ThemeModeSection extends ConsumerWidget {
  const ThemeModeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<String> themeModeNames = ["Light", "Dark", "System"];
    return Card(
      child: ListTile(
        title: const Text("Application Theme"),
        subtitle: const Text("Select application theme"),
        trailing: DropdownButton<String>(
          value: ref.watch(timerProvider).dispEtc.currentThemeMode == ThemeMode.light
              ? "Light"
              : ref.watch(timerProvider).dispEtc.currentThemeMode == ThemeMode.dark
                  ? "Dark"
                  : "System",
          items: themeModeNames.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? s) {
            ref.read(timerProvider.notifier).changeThemeMode(s!);
          },
        ),
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        const Text(
          "Version 0.5.0",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text(
          "Made with <3 by bootloopmaster636, Byonicku, and other contributors",
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 160,
          child: TextButton(
              onPressed: _launchURL,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.github),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Visit us on Github"),
                ],
              )),
        ),
      ],
    );
  }

  Future<void> _launchURL() async {
    final url = Uri.parse('https://www.github.com/bootloopmaster636/ugd_timer');
    await canLaunchUrl(url) ? await launchUrl(url) : throw 'Could not launch $url';
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16, bottom: 8),
      child: Text(title, style: const TextStyle(fontSize: 24)),
    );
  }
}

Future<TimeOfDay?> ShowTimePickerDialog(BuildContext context) async {
  final time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true, textScaleFactor: 1.2),
          child: child!,
        );
      });
  return time;
}
