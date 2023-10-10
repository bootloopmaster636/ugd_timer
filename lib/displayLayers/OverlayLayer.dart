import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugd_timer/logic/managers/NotificationManager.dart';
import 'package:ugd_timer/logic/managers/TimerManager.dart';
import 'package:ugd_timer/main.dart';
import 'package:url_launcher/url_launcher.dart';

class OverlayLayer extends ConsumerWidget {
  const OverlayLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayStateWatcher = ref.watch(displayStateProvider);

    return Animate(
      effects: [
        SlideEffect(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOutCubic,
            begin: Offset(
                -1 + (MediaQuery.of(context).size.width - 400) / MediaQuery.of(context).size.width,
                0,
            ),
            end: const Offset(0, 0))
      ],
      target: (displayStateWatcher.settingsExpanded) ? 1 : 0,
      child: const SettingsPanelInside(),
    );
  }
}

class SettingsPanelInside extends ConsumerWidget {
  const SettingsPanelInside({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayStateWatcher = ref.watch(displayStateProvider);

    return Stack(
      children: [
        //this widget will act as "press anywhere except settings page to close settings page"
        IgnorePointer(
          ignoring: !displayStateWatcher.settingsExpanded,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: () => displayStateWatcher.toggleSettingsExpanded(),
              ),
            ),
          ),
        ),

        Container(
          width: 400,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
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
                            displayStateWatcher.toggleSettingsExpanded(),
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
                    SectionTitle(title: "Timer Control"),
                    TitleSection(),
                    MainTimerSection(),
                    AssistTimerSection(),
                    BonusTimerSection(),
                    CutOffTimerSection(),
                    SectionTitle(title: "Display"),
                    ThemeModeSection(),
                    DisplayScaleFactorSection(),
                    SectionTitle(title: "Audio Notifications"),
                    AudioNotifAssistAvailable(),
                    AudioNotifCutoffStarted(),
                    AudioNotifAllTimeFinished(),
                    SectionTitle(title: "Import / Export Settings"),
                    ImportExportSection(),
                    AboutUs(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImportExportSection extends ConsumerWidget {
  const ImportExportSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    void importSettings() async {
      if (ref.read(timerProvider).isRunning || ref.read(timerProvider).isSet) {
        showToastLocal("Please stop the timer first before importing settings");
        return;
      }

      try {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowedExtensions: ["txt"], allowMultiple: false);

        if (result != null) {
          ref.read(timerProvider).importProfile(result.files.single.path!);
          _controller =
              TextEditingController(text: ref.read(timerProvider).getTitle());
          showToastLocal("Settings successfully imported");
        } else {
          showToastLocal("No file selected");
        }
      } catch (e) {
        showToastLocal("Invalid file format");
        return;
      }
    }

    void exportSettings() async {
      if (ref.read(timerProvider).isRunning || ref.read(timerProvider).isSet) {
        showToastLocal("Please stop the timer first before exporting settings");
        return;
      }

      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select where to save this settings',
        fileName: "${ref.read(timerProvider).displayManager.title}.txt",
      );

      if (outputFile != null) {
        ref.read(timerProvider).exportProfile(outputFile);
        showToastLocal("Settings successfully exported");
      } else {
        showToastLocal("No file selected");
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          onPressed: importSettings,
          child: const Row(
            children: [
              Icon(Icons.file_download_outlined),
              SizedBox(width: 8),
              Text("Import"),
            ],
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: exportSettings,
          child: const Row(
            children: [
              Icon(Icons.upload_file_outlined),
              SizedBox(width: 8),
              Text("Export"),
            ],
          ),
        ),
      ],
    );
  }
}

TextEditingController _controller = TextEditingController();

class TitleSection extends ConsumerWidget {
  const TitleSection({Key? key}) : super(key: key);

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
            },
          ),
        ),
      ),
    );
  }
}

class MainTimerSection extends ConsumerWidget {
  const MainTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);
    final timerManager = ref.watch(timerProvider).timerManager;

    return Card(
      child: ListTile(
        title: const Text("Main timer"),
        subtitle: const Text("Set the main timer duration"),
        trailing: Text(
          "${timerManager.getTimer(TimerType.main).inMinutes} minutes",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () async => timerWatcher.setTimer(
          TimerType.main,
          await showTimePickerDialog(context),
        ),
      ),
    );
  }
}

class AssistTimerSection extends ConsumerWidget {
  const AssistTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);
    final timerManager = ref.watch(timerProvider).timerManager;

    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    return Card(
      child: ListTile(
          title: const Text("Assistant timer"),
          subtitle:
              const Text("Set the duration where student can ask for help"),
          trailing: Text(
            "${timerManager.getTimer(TimerType.assist).inMinutes} minutes",
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () async {
            if (!timerManager.isTimerSet(TimerType.main)) {
              showToastLocal(
                "Main timer must be set first",
              );
              return;
            }

            final timePicker = await showTimePickerDialog(context);
            final timeDuration = Duration(
              hours: timePicker!.hour,
              minutes: timePicker.minute,
            );

            if (timeDuration > timerManager.getTimer(TimerType.main)) {
              showToastLocal(
                "Assistant timer must be less or same with main timer",
              );
              return;
            }

            timerWatcher.setTimer(
              TimerType.assist,
              timePicker,
            );
          }),
    );
  }
}

class BonusTimerSection extends ConsumerWidget {
  const BonusTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);
    final timerManager = ref.watch(timerProvider).timerManager;

    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    return Card(
      child: ListTile(
        title: const Text("Bonus timer"),
        subtitle: const Text("Submission must be made before this timer ends"),
        trailing: Text(
          "${timerManager.getTimer(TimerType.bonus).inMinutes} minutes",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () async {
          if (timerManager.getTimer(TimerType.main).inSeconds == 0) {
            showToastLocal(
              "Main timer must be set first",
            );
            return;
          }

          final timePicker = await showTimePickerDialog(context);
          final timeDuration = Duration(
            hours: timePicker!.hour,
            minutes: timePicker.minute,
          );

          if (timeDuration > timerManager.getTimer(TimerType.main)) {
            showToastLocal(
              "Bonus timer must be less or same with main timer",
            );
            return;
          }

          timerWatcher.setTimer(
            TimerType.bonus,
            timePicker,
          );
        },
      ),
    );
  }
}

class CutOffTimerSection extends ConsumerWidget {
  const CutOffTimerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);
    final timerManager = ref.watch(timerProvider).timerManager;

    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    return Card(
      child: ListTile(
          title: const Text("Cut off timer"),
          subtitle: const Text(
              "Maximum time for submission after main timer ran out"),
          trailing: Text(
            "${timerManager.getTimer(TimerType.cutoff).inMinutes} minutes",
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () async {
            if (timerManager.getTimer(TimerType.main).inSeconds == 0) {
              showToastLocal(
                "Main timer must be set first",
              );
              return;
            }

            final timePicker = await showTimePickerDialog(context);
            final timeDuration = Duration(
              hours: timePicker!.hour,
              minutes: timePicker.minute,
            );

            if (timeDuration > timerManager.getTimer(TimerType.main)) {
              showToastLocal(
                "Cut off timer must be less or same with main timer",
              );
              return;
            }

            timerWatcher.setTimer(
              TimerType.cutoff,
              timePicker,
            );
          }),
    );
  }
}

class DisplayScaleFactorSection extends ConsumerWidget {
  const DisplayScaleFactorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayStateWatcher = ref.watch(displayStateProvider);

    return Card(
      child: ListTile(
          title: const Text("Display scale factor"),
          subtitle: Slider(
            value: ref.watch(displayStateProvider).displayFontScale,
            min: 0.8,
            max: 1.8,
            divisions: 11,
            onChanged: (value) =>
                displayStateWatcher.setDisplayFontScale(value),
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
          value: ref.watch(timerProvider).displayManager.currentThemeMode ==
                  ThemeMode.light
              ? "Light"
              : ref.watch(timerProvider).displayManager.currentThemeMode ==
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

class AudioNotifAssistAvailable extends ConsumerWidget {
  const AudioNotifAssistAvailable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);

    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    return Card(
        child: Column(
      children: [
        ListTile(
          title: const Text("Assist available"),
          subtitle: const Text("Play sound when participant can ask for help"),
          trailing: Switch(
            value: timerWatcher.notificationManager
                .getNotificationState(NotificationType.assistAvailable),
            onChanged: (value) {
              timerWatcher
                  .toggleSoundAvailable(NotificationType.assistAvailable);
            },
          ),
        ),
        ListTile(
          enabled: timerWatcher.notificationManager
              .getNotificationState(NotificationType.assistAvailable),
          title: const Text("Audio to play"),
          onTap: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.audio);

            if (result != null) {
              timerWatcher.setSoundPath(NotificationType.assistAvailable,
                  File(result.files.single.path!));
            } else {
              showToastLocal("No audio file selected");
              timerWatcher
                  .toggleSoundAvailable(NotificationType.assistAvailable);
            }
          },
          trailing: SizedBox(
            width: 160,
            child: Text(
              timerWatcher.notificationManager
                  .getNotificationSoundPath(NotificationType.assistAvailable)
                  .path
                  .split("/")
                  .last,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    ));
  }
}

class AudioNotifCutoffStarted extends ConsumerWidget {
  const AudioNotifCutoffStarted({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);

    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    return Card(
        child: Column(
      children: [
        ListTile(
          title: const Text("Timer cut off start"),
          subtitle: const Text("Play sound when cut off timer starts"),
          trailing: Switch(
            value: timerWatcher.notificationManager
                .getNotificationState(NotificationType.cutoffStarted),
            onChanged: (value) {
              timerWatcher.toggleSoundAvailable(NotificationType.cutoffStarted);
            },
          ),
        ),
        ListTile(
          enabled: timerWatcher.notificationManager
              .getNotificationState(NotificationType.cutoffStarted),
          title: const Text("Audio to play"),
          onTap: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.audio);

            if (result != null) {
              timerWatcher.setSoundPath(NotificationType.cutoffStarted,
                  File(result.files.single.path!));
            } else {
              showToastLocal("No audio file selected");
              timerWatcher.toggleSoundAvailable(NotificationType.cutoffStarted);
            }
          },
          trailing: SizedBox(
            width: 160,
            child: Text(
              timerWatcher.notificationManager
                  .getNotificationSoundPath(NotificationType.cutoffStarted)
                  .path
                  .split("/")
                  .last,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    ));
  }
}

class AudioNotifAllTimeFinished extends ConsumerWidget {
  const AudioNotifAllTimeFinished({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerWatcher = ref.watch(timerProvider);

    void showToastLocal(String message) {
      showToast(message, context: context);
    }

    return Card(
        child: Column(
      children: [
        ListTile(
          title: const Text("All timer finished"),
          subtitle: const Text("Play sound when all timer already finished"),
          trailing: Switch(
            value: timerWatcher.notificationManager
                .getNotificationState(NotificationType.allTimerFinished),
            onChanged: (value) {
              timerWatcher
                  .toggleSoundAvailable(NotificationType.allTimerFinished);
            },
          ),
        ),
        ListTile(
          enabled: timerWatcher.notificationManager
              .getNotificationState(NotificationType.allTimerFinished),
          title: const Text("Audio to play"),
          onTap: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(type: FileType.audio);

            if (result != null) {
              timerWatcher.setSoundPath(NotificationType.allTimerFinished,
                  File(result.files.single.path!));
            } else {
              showToastLocal("No audio file selected");
              timerWatcher
                  .toggleSoundAvailable(NotificationType.allTimerFinished);
            }
          },
          trailing: SizedBox(
            width: 160,
            child: Text(
              timerWatcher.notificationManager
                  .getNotificationSoundPath(NotificationType.allTimerFinished)
                  .path
                  .split("/")
                  .last,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
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
          "Version 0.8.0",
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
      helpText: "Set timer duration",
      errorInvalidText: "Invalid",
      confirmText: "Set",
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
