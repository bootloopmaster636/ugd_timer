// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_conf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimerConf _$TimerConfFromJson(Map<String, dynamic> json) {
  return _TimerConf.fromJson(json);
}

/// @nodoc
mixin _$TimerConf {
  String get title => throw _privateConstructorUsedError;
  bool get assistTimerEnabled => throw _privateConstructorUsedError;
  bool get bonusTimerEnabled => throw _privateConstructorUsedError;
  String get warningAudioPath => throw _privateConstructorUsedError;
  String get endAudioPath => throw _privateConstructorUsedError;
  String get startCutoffAudioPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerConfCopyWith<TimerConf> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerConfCopyWith<$Res> {
  factory $TimerConfCopyWith(TimerConf value, $Res Function(TimerConf) then) =
      _$TimerConfCopyWithImpl<$Res, TimerConf>;
  @useResult
  $Res call(
      {String title,
      bool assistTimerEnabled,
      bool bonusTimerEnabled,
      String warningAudioPath,
      String endAudioPath,
      String startCutoffAudioPath});
}

/// @nodoc
class _$TimerConfCopyWithImpl<$Res, $Val extends TimerConf>
    implements $TimerConfCopyWith<$Res> {
  _$TimerConfCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? assistTimerEnabled = null,
    Object? bonusTimerEnabled = null,
    Object? warningAudioPath = null,
    Object? endAudioPath = null,
    Object? startCutoffAudioPath = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      assistTimerEnabled: null == assistTimerEnabled
          ? _value.assistTimerEnabled
          : assistTimerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      bonusTimerEnabled: null == bonusTimerEnabled
          ? _value.bonusTimerEnabled
          : bonusTimerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      warningAudioPath: null == warningAudioPath
          ? _value.warningAudioPath
          : warningAudioPath // ignore: cast_nullable_to_non_nullable
              as String,
      endAudioPath: null == endAudioPath
          ? _value.endAudioPath
          : endAudioPath // ignore: cast_nullable_to_non_nullable
              as String,
      startCutoffAudioPath: null == startCutoffAudioPath
          ? _value.startCutoffAudioPath
          : startCutoffAudioPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerConfImplCopyWith<$Res>
    implements $TimerConfCopyWith<$Res> {
  factory _$$TimerConfImplCopyWith(
          _$TimerConfImpl value, $Res Function(_$TimerConfImpl) then) =
      __$$TimerConfImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      bool assistTimerEnabled,
      bool bonusTimerEnabled,
      String warningAudioPath,
      String endAudioPath,
      String startCutoffAudioPath});
}

/// @nodoc
class __$$TimerConfImplCopyWithImpl<$Res>
    extends _$TimerConfCopyWithImpl<$Res, _$TimerConfImpl>
    implements _$$TimerConfImplCopyWith<$Res> {
  __$$TimerConfImplCopyWithImpl(
      _$TimerConfImpl _value, $Res Function(_$TimerConfImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? assistTimerEnabled = null,
    Object? bonusTimerEnabled = null,
    Object? warningAudioPath = null,
    Object? endAudioPath = null,
    Object? startCutoffAudioPath = null,
  }) {
    return _then(_$TimerConfImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      assistTimerEnabled: null == assistTimerEnabled
          ? _value.assistTimerEnabled
          : assistTimerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      bonusTimerEnabled: null == bonusTimerEnabled
          ? _value.bonusTimerEnabled
          : bonusTimerEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      warningAudioPath: null == warningAudioPath
          ? _value.warningAudioPath
          : warningAudioPath // ignore: cast_nullable_to_non_nullable
              as String,
      endAudioPath: null == endAudioPath
          ? _value.endAudioPath
          : endAudioPath // ignore: cast_nullable_to_non_nullable
              as String,
      startCutoffAudioPath: null == startCutoffAudioPath
          ? _value.startCutoffAudioPath
          : startCutoffAudioPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimerConfImpl implements _TimerConf {
  _$TimerConfImpl(
      {required this.title,
      required this.assistTimerEnabled,
      required this.bonusTimerEnabled,
      required this.warningAudioPath,
      required this.endAudioPath,
      required this.startCutoffAudioPath});

  factory _$TimerConfImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerConfImplFromJson(json);

  @override
  final String title;
  @override
  final bool assistTimerEnabled;
  @override
  final bool bonusTimerEnabled;
  @override
  final String warningAudioPath;
  @override
  final String endAudioPath;
  @override
  final String startCutoffAudioPath;

  @override
  String toString() {
    return 'TimerConf(title: $title, assistTimerEnabled: $assistTimerEnabled, bonusTimerEnabled: $bonusTimerEnabled, warningAudioPath: $warningAudioPath, endAudioPath: $endAudioPath, startCutoffAudioPath: $startCutoffAudioPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerConfImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.assistTimerEnabled, assistTimerEnabled) ||
                other.assistTimerEnabled == assistTimerEnabled) &&
            (identical(other.bonusTimerEnabled, bonusTimerEnabled) ||
                other.bonusTimerEnabled == bonusTimerEnabled) &&
            (identical(other.warningAudioPath, warningAudioPath) ||
                other.warningAudioPath == warningAudioPath) &&
            (identical(other.endAudioPath, endAudioPath) ||
                other.endAudioPath == endAudioPath) &&
            (identical(other.startCutoffAudioPath, startCutoffAudioPath) ||
                other.startCutoffAudioPath == startCutoffAudioPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, assistTimerEnabled,
      bonusTimerEnabled, warningAudioPath, endAudioPath, startCutoffAudioPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerConfImplCopyWith<_$TimerConfImpl> get copyWith =>
      __$$TimerConfImplCopyWithImpl<_$TimerConfImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerConfImplToJson(
      this,
    );
  }
}

abstract class _TimerConf implements TimerConf {
  factory _TimerConf(
      {required final String title,
      required final bool assistTimerEnabled,
      required final bool bonusTimerEnabled,
      required final String warningAudioPath,
      required final String endAudioPath,
      required final String startCutoffAudioPath}) = _$TimerConfImpl;

  factory _TimerConf.fromJson(Map<String, dynamic> json) =
      _$TimerConfImpl.fromJson;

  @override
  String get title;
  @override
  bool get assistTimerEnabled;
  @override
  bool get bonusTimerEnabled;
  @override
  String get warningAudioPath;
  @override
  String get endAudioPath;
  @override
  String get startCutoffAudioPath;
  @override
  @JsonKey(ignore: true)
  _$$TimerConfImplCopyWith<_$TimerConfImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
