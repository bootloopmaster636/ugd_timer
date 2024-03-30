import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/data/appSettings/app_settings_persistence.dart';
import 'package:ugd_timer/logic/settings/app_settings.dart';
import 'package:ugd_timer/logic/ui/navigation.dart';

class ApplicationSettingsPage extends ConsumerWidget {
  const ApplicationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      FluentIcons.back,
                      size: 20,
                    ),
                    onPressed: () {
                      ref.read(topWidgetLogicProvider.notifier).backToTimer();
                    },
                  ),
                  const Gap(8),
                  Text(
                    AppLocalizations.of(context)!.appSettings,
                    style: FluentTheme.of(context).typography.title,
                  ),
                ],
              ),
              const Gap(16),
              const AppSettingsContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppSettingsContent extends StatelessWidget {
  const AppSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <HookConsumerWidget>[
          const LanguageSettings(),
          const ThemeModeSettings(),
        ]
            .map((HookConsumerWidget e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: e,
                ),)
            .toList(),
      ),
    );
  }
}

class LanguageSettings extends HookConsumerWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isExpanded = useState(false);
    return Expander(
      header: Text(AppLocalizations.of(context)!.language),
      trailing: Text(languageName[languageCode.indexOf(ref.watch(appSettingsLogicProvider).languageCode)]),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: SingleChildScrollView(
          child: Column(
            children: languageCode.map((String e) {
              return ListTile(
                title: Text(
                  languageName[languageCode.indexOf(e)],
                  style: FluentTheme.of(context).typography.body,
                ),
                leading: RadioButton(
                  checked: ref.watch(appSettingsLogicProvider).languageCode == e,
                  semanticLabel: languageName[languageCode.indexOf(e)],
                  onChanged: (bool value) {
                    ref.read(appSettingsLogicProvider.notifier).setLanguageCode(e);
                    ref.read(appSettingsPersistenceProvider.notifier).saveSettings();
                    isExpanded.value = false;
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ThemeModeSettings extends HookConsumerWidget {
  const ThemeModeSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> themeModeName = <String>['System', 'Light', 'Dark'];
    return Card(
      padding: EdgeInsets.zero,
      child: ListTile(
        title: Text(
          AppLocalizations.of(context)!.themeMode,
          style: FluentTheme.of(context).typography.body,
        ),
        trailing: ComboBox<String>(
          value: themeModeName[ref.watch(appSettingsLogicProvider).themeMode.index],
          items: themeModeName.map((String e) {
            return ComboBoxItem<String>(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: (String? val) {
            ref.read(appSettingsLogicProvider.notifier).setThemeMode(val ?? 'System');
            ref.read(appSettingsPersistenceProvider.notifier).saveSettings();
          },
        ),
      ),
    );
  }
}
