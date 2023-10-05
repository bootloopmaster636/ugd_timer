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
        SlideEffect(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
            begin: Offset(-1, 0),
            end: Offset(0, 0))
      ],
      target: (displayStateWatcher.settingsExpanded) ? 1 : 0,
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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () =>
                        ref.read(displayStateProvider).toggleSettingsExpanded(),
                    child: const Icon(Icons.arrow_back)),
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
                SectionTitle(title: "Import / Export Settings"),
                SectionTitle(title: "Timer Control"),
                TitleSection(),
                MainTimerSection(),
                AssistTimerSection(),
                BonusTimerSection(),
                CutOffTimerSection(),
                SectionTitle(title: "Display"),
                ThemeModeSection(),
                DisplayctorSection(),
                SectionTitle(title: "Audio Notifications"),
                AudioNotifTimerFinished(),
                AudioNotifAssistAvailable(),
                AudioNotifCutoffStarted(),
                AboutUs(),
              ],
            ),
          ),
        ],
      ),
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
        onTap: () async => ref
            .read(timerProvider)
            .setMainTimer(timeFromPicker: await showTimePickerDialog(context)),
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
        onTap: () async => ref.read(timerProvider).setAssistTimer(
            timeFromPicker: await showTimePickerDialog(context)),
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
        onTap: () async => ref
            .read(timerProvider)
            .setBonusTimer(timeFromPicker: await showTimePickerDialog(context)),
      ),
    );
  }
}

class CutOffTimerSection extends ConsumerWidget {
  const CutOffTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: const Text("Cut off timer"),
        subtitle:
            const Text("Maximum time for submission after main timer ran out"),
        trailing: Text(
          "${ref.watch(timerProvider).cutOffTimer.inMinutes} minutes",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () async => ref.read(timerProvider).setCutOffTimer(
            timeFromPicker: await showTimePickerDialog(context)),
      ),
    );
  }
}

class DisplayctorSection extends ConsumerWidget {
  const DisplayctorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
          title: const Text("Display scale factor"),
          subtitle: Slider(
            value: ref.watch(displayStateProvider).displayFontScale,
            min: 0.8,
            max: 1.8,
            divisions: 11,
            onChanged: (value) =>
                ref.read(displayStateProvider).setDisplayFontScale(value),
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
          value: ref.watch(timerProvider).dispEtc.currentThemeMode ==
                  ThemeMode.light
              ? "Light"
              : ref.watch(timerProvider).dispEtc.currentThemeMode ==
                      ThemeMode.dark
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

class AudioNotifTimerFinished extends ConsumerWidget {
  const AudioNotifTimerFinished({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: Column(
      children: [
        ListTile(
          title: const Text("Timer finished"),
          subtitle: const Text("Play sound when timer finished"),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              print(value);
            },
          ),
        ),
        ListTile(
          enabled: false,
          title: const Text("Audio to play"),
        ),
      ],
    ));
  }
}

class AudioNotifAssistAvailable extends ConsumerWidget {
  const AudioNotifAssistAvailable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: Column(
      children: [
        ListTile(
          title: const Text("Assist available"),
          subtitle: const Text("Play sound when participant can ask for help"),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              print(value);
            },
          ),
        ),
        ListTile(
          enabled: false,
          title: const Text("Audio to play"),
        ),
      ],
    ));
  }
}

class AudioNotifCutoffStarted extends ConsumerWidget {
  const AudioNotifCutoffStarted({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: Column(
          children: [
            ListTile(
              title: const Text("Timer cut off start"),
              subtitle: const Text("Play sound when timer finished"),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            ListTile(
              enabled: false,
              title: const Text("Audio to play"),
            ),
          ],
        ));
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
          "Version 0.5.3",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Made with ❤️ by bootloopmaster636, byonicku, and other contributors",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 180,
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
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'Could not launch $url';
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

Future<TimeOfDay?> showTimePickerDialog(BuildContext context) async {
  final time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      orientation: Orientation.landscape,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: true, textScaleFactor: 1.2),
          child: child!,
        );
      });
  return time;
}
