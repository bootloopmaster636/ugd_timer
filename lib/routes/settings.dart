import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_timer/main.dart';

final _titleController = TextEditingController();
final List<String> themeModeNames = ["System", "Light", "Dark"];

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Timer configuration",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 6,
              ),
              Card(
                child: ListTile(
                  title: const Text("Set timer title"),
                  subtitle: Container(
                    margin: const EdgeInsets.only(bottom: 8.0, right: 36),
                    child: TextField(
                      controller: _titleController,
                      onChanged: (s) {
                        ref.read(timerProvider).setTitle(s);
                        _titleController.text = s;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Card(
                child: ListTile(
                  title: const Text("Select timer duration"),
                  subtitle: Text(
                      "timer duration is ${ref.watch(timerProvider).mainTimer.inMinutes.toString()} minutes"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    ref.read(timerProvider.notifier).setMainTimer(
                        timeFromPicker: await ShowTimePickerDialog(context));
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Card(
                child: ListTile(
                  title: const Text("Select assist time"),
                  subtitle: Text(
                      "assistant will be available after ${ref.watch(timerProvider).assistTimer.inMinutes.toString()} minutes"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async => ref
                      .read(timerProvider.notifier)
                      .setAssistTimer(
                          timeFromPicker: await ShowTimePickerDialog(context)),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Card(
                child: ListTile(
                  title: const Text("Select bonus"),
                  subtitle: Text(
                      "bonus should be submitted below ${ref.watch(timerProvider).bonusTimer.inMinutes.toString()} minutes after timer starts"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async => ref
                      .read(timerProvider.notifier)
                      .setBonusTimer(
                          timeFromPicker: await ShowTimePickerDialog(context)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("App Settings",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 6,
              ),
              Card(
                child: ListTile(
                  title: const Text("Select application theme mode"),
                  subtitle: Text("Light attract bugs!"),
                  trailing: DropdownButton<String>(
                    value: ref.watch(timerProvider).dispEtc.currentThemeMode ==
                            ThemeMode.light
                        ? "Light"
                        : ref.watch(timerProvider).dispEtc.currentThemeMode ==
                                ThemeMode.dark
                            ? "Dark"
                            : "System",
                    items: themeModeNames
                        .map<DropdownMenuItem<String>>((String value) {
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
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back to timer page")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 60,
          child: Text(
            "made with <3 by bootloopmaster636, byonicku, and other contributors\nsource code is FOSS and available at github.com/bootloopmaster636/ugd_timer",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )),
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
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      });
  return time;
}
