import 'package:fluent_ui/fluent_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appSettings.freezed.dart';
part 'appSettings.g.dart';

@freezed
class AppSettingsModel with _$AppSettingsModel {
  factory AppSettingsModel({
    required String languageCode,
    required ThemeMode themeMode,
  }) = _AppSettingsModel;
}

@riverpod
class AppSettingsLogic extends _$AppSettingsLogic {
  @override
  AppSettingsModel build() {
    return AppSettingsModel(
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
