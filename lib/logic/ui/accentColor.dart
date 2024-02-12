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
  Color build() {
    return Colors.blue;
  }

  void setAccentColorByDuration(Duration now, Duration set) {
    if (now.inSeconds > set.inSeconds * .8) {
      state = Colors.blue;
    } else if (now.inSeconds > set.inSeconds * .6) {
      state = Colors.teal;
    } else if (now.inSeconds > set.inSeconds * .4) {
      state = Colors.green;
    } else if (now.inSeconds > set.inSeconds * .2) {
      state = Colors.orange;
    } else if (now.inSeconds > set.inSeconds * .1) {
      state = Colors.red;
    }
  }
}
