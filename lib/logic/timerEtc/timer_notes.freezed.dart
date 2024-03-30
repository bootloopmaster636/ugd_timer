// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_notes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Notes {
  String get data => throw _privateConstructorUsedError;
  bool get isShown => throw _privateConstructorUsedError;
  NotesShowMode get showMode => throw _privateConstructorUsedError;
  double get textScale => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotesCopyWith<Notes> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotesCopyWith<$Res> {
  factory $NotesCopyWith(Notes value, $Res Function(Notes) then) =
      _$NotesCopyWithImpl<$Res, Notes>;
  @useResult
  $Res call(
      {String data, bool isShown, NotesShowMode showMode, double textScale});
}

/// @nodoc
class _$NotesCopyWithImpl<$Res, $Val extends Notes>
    implements $NotesCopyWith<$Res> {
  _$NotesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? isShown = null,
    Object? showMode = null,
    Object? textScale = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      isShown: null == isShown
          ? _value.isShown
          : isShown // ignore: cast_nullable_to_non_nullable
              as bool,
      showMode: null == showMode
          ? _value.showMode
          : showMode // ignore: cast_nullable_to_non_nullable
              as NotesShowMode,
      textScale: null == textScale
          ? _value.textScale
          : textScale // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotesImplCopyWith<$Res> implements $NotesCopyWith<$Res> {
  factory _$$NotesImplCopyWith(
          _$NotesImpl value, $Res Function(_$NotesImpl) then) =
      __$$NotesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String data, bool isShown, NotesShowMode showMode, double textScale});
}

/// @nodoc
class __$$NotesImplCopyWithImpl<$Res>
    extends _$NotesCopyWithImpl<$Res, _$NotesImpl>
    implements _$$NotesImplCopyWith<$Res> {
  __$$NotesImplCopyWithImpl(
      _$NotesImpl _value, $Res Function(_$NotesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? isShown = null,
    Object? showMode = null,
    Object? textScale = null,
  }) {
    return _then(_$NotesImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      isShown: null == isShown
          ? _value.isShown
          : isShown // ignore: cast_nullable_to_non_nullable
              as bool,
      showMode: null == showMode
          ? _value.showMode
          : showMode // ignore: cast_nullable_to_non_nullable
              as NotesShowMode,
      textScale: null == textScale
          ? _value.textScale
          : textScale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$NotesImpl implements _Notes {
  _$NotesImpl(
      {required this.data,
      required this.isShown,
      required this.showMode,
      required this.textScale});

  @override
  final String data;
  @override
  final bool isShown;
  @override
  final NotesShowMode showMode;
  @override
  final double textScale;

  @override
  String toString() {
    return 'Notes(data: $data, isShown: $isShown, showMode: $showMode, textScale: $textScale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotesImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.isShown, isShown) || other.isShown == isShown) &&
            (identical(other.showMode, showMode) ||
                other.showMode == showMode) &&
            (identical(other.textScale, textScale) ||
                other.textScale == textScale));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, data, isShown, showMode, textScale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotesImplCopyWith<_$NotesImpl> get copyWith =>
      __$$NotesImplCopyWithImpl<_$NotesImpl>(this, _$identity);
}

abstract class _Notes implements Notes {
  factory _Notes(
      {required final String data,
      required final bool isShown,
      required final NotesShowMode showMode,
      required final double textScale}) = _$NotesImpl;

  @override
  String get data;
  @override
  bool get isShown;
  @override
  NotesShowMode get showMode;
  @override
  double get textScale;
  @override
  @JsonKey(ignore: true)
  _$$NotesImplCopyWith<_$NotesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
