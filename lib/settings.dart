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
              FilledButton(onPressed: () => Navigator.pop(context), child: const Text("Back to timer page")),
            ],
          ),
        ),
      ),
    );
  }
}
