import 'package:fluent_ui/fluent_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

@freezed
class AppSettings with _$AppSettings {
  factory AppSettings({
    required String languageCode,
    required ThemeMode themeMode,
  }) = _AppSettingsModel;
}

@riverpod
class AppSettingsLogic extends _$AppSettingsLogic {
  @override
  AppSettings build() {
    return AppSettings(
      languageCode: 'en',
      themeMode: ThemeMode.system,
    );
  }

  void setLanguageCode(String languageCode) {
    state = state.copyWith(languageCode: languageCode);
  }

  void setThemeMode(String themeMode) {
    if (themeMode == 'System') {
      state = state.copyWith(themeMode: ThemeMode.system);
    } else if (themeMode == 'Light') {
      state = state.copyWith(themeMode: ThemeMode.light);
    } else if (themeMode == 'Dark') {
      state = state.copyWith(themeMode: ThemeMode.dark);
    }
  }
}
