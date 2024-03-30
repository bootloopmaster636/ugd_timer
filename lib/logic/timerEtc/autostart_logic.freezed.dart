// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'autostart_logic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AutoStartClock {
  Duration get startAt => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AutoStartClockCopyWith<AutoStartClock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AutoStartClockCopyWith<$Res> {
  factory $AutoStartClockCopyWith(
          AutoStartClock value, $Res Function(AutoStartClock) then) =
      _$AutoStartClockCopyWithImpl<$Res, AutoStartClock>;
  @useResult
  $Res call({Duration startAt, String message, bool enabled});
}

/// @nodoc
class _$AutoStartClockCopyWithImpl<$Res, $Val extends AutoStartClock>
    implements $AutoStartClockCopyWith<$Res> {
  _$AutoStartClockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startAt = null,
    Object? message = null,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as Duration,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AutoStartClockImplCopyWith<$Res>
    implements $AutoStartClockCopyWith<$Res> {
  factory _$$AutoStartClockImplCopyWith(_$AutoStartClockImpl value,
          $Res Function(_$AutoStartClockImpl) then) =
      __$$AutoStartClockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration startAt, String message, bool enabled});
}

/// @nodoc
class __$$AutoStartClockImplCopyWithImpl<$Res>
    extends _$AutoStartClockCopyWithImpl<$Res, _$AutoStartClockImpl>
    implements _$$AutoStartClockImplCopyWith<$Res> {
  __$$AutoStartClockImplCopyWithImpl(
      _$AutoStartClockImpl _value, $Res Function(_$AutoStartClockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startAt = null,
    Object? message = null,
    Object? enabled = null,
  }) {
    return _then(_$AutoStartClockImpl(
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as Duration,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AutoStartClockImpl implements _AutoStartClock {
  _$AutoStartClockImpl(
      {required this.startAt, required this.message, required this.enabled});

  @override
  final Duration startAt;
  @override
  final String message;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'AutoStartClock(startAt: $startAt, message: $message, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AutoStartClockImpl &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startAt, message, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AutoStartClockImplCopyWith<_$AutoStartClockImpl> get copyWith =>
      __$$AutoStartClockImplCopyWithImpl<_$AutoStartClockImpl>(
          this, _$identity);
}

abstract class _AutoStartClock implements AutoStartClock {
  factory _AutoStartClock(
      {required final Duration startAt,
      required final String message,
      required final bool enabled}) = _$AutoStartClockImpl;

  @override
  Duration get startAt;
  @override
  String get message;
  @override
  bool get enabled;
  @override
  @JsonKey(ignore: true)
  _$$AutoStartClockImplCopyWith<_$AutoStartClockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
