import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer UGD',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Theme.of(context).colorScheme.primaryContainer, Theme.of(context).colorScheme.tertiaryContainer],
            )),
          ),
          Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                      const Text(
                        "HH : MM : SS",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.watch_later_outlined),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "HH : MM",
                                style: TextStyle(fontSize: 24),
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
                            onPressed: () => print("Timer toggle start/stop"),
                            child: const Text("Start/Stop"),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          OutlinedButton(
                            onPressed: () => print("Launch Timer settings"),
                            child: const Text("Timer settigns"),
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
                        size: 48,
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Dapat bertanya asisten?\n",
                          style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer, fontSize: 16),
                          children: [
                            TextSpan(text: "XX menit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
