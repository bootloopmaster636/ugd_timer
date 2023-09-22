import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_timer/main.dart';

final _titleController = TextEditingController();

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
              Card(
                child: ListTile(
                  title: const Text("Set timer title"),
                  subtitle: Container(
                    margin: const EdgeInsets.only(bottom: 8.0, right: 36),
                    child: TextField(
                      controller: _titleController,
                      onChanged: (s) {
                        ref.read(timerProvider.notifier).setTitle(s);
                        _titleController.text = s;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                child: ListTile(
                  title: const Text("Select end time"),
                  subtitle: Text(
                      "timer ends at ${ref.watch(timerProvider).endAt.inHours.toString().padLeft(2, '0')} : ${ref.watch(timerProvider).endAt.inMinutes.remainder(60).toString().padLeft(2, '0')}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    ref
                        .read(timerProvider.notifier)
                        .setDisplayTimer(await ShowTimePickerDialog(context));
                    ref
                        .read(timerProvider.notifier)
                        .setEndTimer(ref.watch(timerProvider).displayTimer);
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                child: ListTile(
                  title: const Text("Select assist time"),
                  subtitle: Text(
                      "assist available after ${ref.watch(timerProvider).assistTimer.inMinutes.toString().padLeft(2, '0')} Minutes"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async => ref
                      .read(timerProvider.notifier)
                      .setAssistTimer(await ShowTimePickerDialog(context)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back to timer page")),
            ],
          ),
        ),
      ),
    );
  }
}

Future<TimeOfDay?> ShowTimePickerDialog(BuildContext context) async {
  final time = await showTimePicker(
    initialEntryMode: TimePickerEntryMode.inputOnly,
    context: context,
    initialTime: const TimeOfDay(hour: 0, minute: 0),
  );
  return time;
}
