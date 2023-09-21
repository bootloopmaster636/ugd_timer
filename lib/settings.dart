import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_timer/main.dart';

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
          constraints: BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  title: const Text("Select end time"),
                  subtitle: Text(
                      "Will end at ${ref.watch(TimerProvider).endAt.inHours} : ${ref.watch(TimerProvider).endAt.inMinutes.remainder(60)}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async => ref.read(TimerProvider.notifier).setEndTimer(await ShowTimePickerDialog(context)),
                ),
              ),
              FilledButton(onPressed: () => Navigator.pop(context), child: const Text("Back to timer page")),
            ],
          ),
        ),
      ),
    );
  }
}

Future<TimeOfDay?> ShowTimePickerDialog(BuildContext context) async {
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return time;
}
