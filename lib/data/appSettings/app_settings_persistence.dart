import 'package:fluent_ui/fluent_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_timer/logic/settings/app_settings.dart';

part 'app_settings_persistence.g.dart';

@riverpod
class AppSettingsPersistence extends _$AppSettingsPersistence {
  @override
  Future<void> build() async {
    await loadSettings();
  }

  Future<void> loadSettings() async {
    state = const AsyncLoading<void>();
    final String languageCode = await LanguagePersistence.loadSettings();
    final String themeMode = await ThemePersistence.loadSettings();

    ref.read(appSettingsLogicProvider.notifier).setLanguageCode(languageCode);
    ref.read(appSettingsLogicProvider.notifier).setThemeMode(themeMode);
    state = const AsyncData<void>(null);
  }

  Future<void> saveSettings() async {
    final String languageCode = ref.read(appSettingsLogicProvider).languageCode;
    final ThemeMode themeMode = ref.read(appSettingsLogicProvider).themeMode;

    await LanguagePersistence.saveSettings(languageCode);
    await ThemePersistence.saveSettings(themeMode);
  }
}

class LanguagePersistence {
  static Future<String> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }

  static Future<void> saveSettings(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }
}

class ThemePersistence {
  static Future<String> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String theme = prefs.getString('theme') ?? 'System';
    return theme;
  }

  static Future<void> saveSettings(ThemeMode themeMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.system) {
      await prefs.setString('theme', 'System');
    } else if (themeMode == ThemeMode.light) {
      await prefs.setString('theme', 'Light');
    } else if (themeMode == ThemeMode.dark) {
      await prefs.setString('theme', 'Dark');
    }
  }
}
