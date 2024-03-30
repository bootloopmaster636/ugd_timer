import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ugd_timer/constants.dart';

part 'timer_notes.freezed.dart';
part 'timer_notes.g.dart';

@freezed
class Notes with _$Notes {
  factory Notes({
    required String data,
    required bool isShown,
    required NotesShowMode showMode,
    required double textScale,
  }) = _Notes;
}

@riverpod
class NotesLogic extends _$NotesLogic {
  @override
  Notes build() {
    return Notes(
      data: '',
      isShown: false,
      showMode: NotesShowMode.edit,
      textScale: 1,
    );
  }

  void setNotes(String data) {
    state = state.copyWith(data: data);
  }

  void clearNotes() {
    state = state.copyWith(data: '');
  }

  void toggleNotes() {
    state = state.copyWith(isShown: !state.isShown);
  }

  void setShowMode(NotesShowMode showMode) {
    state = state.copyWith(showMode: showMode);
  }

  void increaseTextSize({bool jump = false}) {
    state = state.copyWith(textScale: state.textScale + (jump ? 1 : 0.2));
  }

  void decreaseTextSize({bool jump = false}) {
    state = state.copyWith(textScale: state.textScale - (jump ? 1 : 0.2));
    if (state.textScale < 0.4) state = state.copyWith(textScale: 0.4);
  }

  void resetTextSize() {
    state = state.copyWith(textScale: 1);
  }
}
