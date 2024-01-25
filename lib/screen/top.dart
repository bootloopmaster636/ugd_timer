import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopLayer extends StatelessWidget {
  const TopLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Placeholder(),
        Text(AppLocalizations.of(context)!.helloWorld),
      ],
    );
  }
}
