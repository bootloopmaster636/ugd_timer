import 'package:fluent_ui/fluent_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accentColor.freezed.dart';
part 'accentColor.g.dart';

@freezed
class AccentColor with _$AccentColor {
  factory AccentColor({
    required Color accentColor,
  }) = _AccentColor;
}

@riverpod
class AccentColorState extends _$AccentColorState {
  @override
  AccentColor build() {
    return AccentColor(accentColor: Colors.blue);
  }

  void setAccentColorByDuration(Duration now, Duration set) {
    if (now.inSeconds > set.inSeconds * .8) {
      state = AccentColor(accentColor: Colors.blue);
    } else if (now.inSeconds > set.inSeconds * .6) {
      state = AccentColor(accentColor: Colors.teal);
    } else if (now.inSeconds > set.inSeconds * .4) {
      state = AccentColor(accentColor: Colors.green);
    } else if (now.inSeconds > set.inSeconds * .2) {
      state = AccentColor(accentColor: Colors.orange);
    } else if (now.inSeconds > set.inSeconds * .1) {
      state = AccentColor(accentColor: Colors.red);
    }
  }
}
