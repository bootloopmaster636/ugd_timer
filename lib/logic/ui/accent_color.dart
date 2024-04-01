import 'package:fluent_ui/fluent_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accent_color.freezed.dart';
part 'accent_color.g.dart';

@freezed
class DynamicAccentColor with _$DynamicAccentColor {
  factory DynamicAccentColor({
    required Color accentColor,
  }) = _AccentColor;
}

@riverpod
class AccentColorState extends _$AccentColorState {
  @override
  DynamicAccentColor build() {
    return DynamicAccentColor(accentColor: Colors.blue);
  }

  void setAccentColorByDuration(Duration now, Duration set) {
    if (now.inSeconds > set.inSeconds * .8) {
      state = DynamicAccentColor(accentColor: Colors.blue);
    } else if (now.inSeconds > set.inSeconds * .6) {
      state = DynamicAccentColor(accentColor: Colors.teal);
    } else if (now.inSeconds > set.inSeconds * .4) {
      state = DynamicAccentColor(accentColor: Colors.green);
    } else if (now.inSeconds > set.inSeconds * .2) {
      state = DynamicAccentColor(accentColor: Colors.orange);
    } else if (now.inSeconds > set.inSeconds * .1) {
      state = DynamicAccentColor(accentColor: Colors.red);
    }
  }
}
