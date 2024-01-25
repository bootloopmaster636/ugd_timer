// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Clock {
  Duration get currentTimer => throw _privateConstructorUsedError;
  Duration get assistTimer => throw _privateConstructorUsedError;
  Duration get bonusTimer => throw _privateConstructorUsedError;
  TimerStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClockCopyWith<Clock> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClockCopyWith<$Res> {
  factory $ClockCopyWith(Clock value, $Res Function(Clock) then) =
      _$ClockCopyWithImpl<$Res, Clock>;
  @useResult
  $Res call(
      {Duration currentTimer,
      Duration assistTimer,
      Duration bonusTimer,
      TimerStatus status});
}

/// @nodoc
class _$ClockCopyWithImpl<$Res, $Val extends Clock>
    implements $ClockCopyWith<$Res> {
  _$ClockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTimer = null,
    Object? assistTimer = null,
    Object? bonusTimer = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      currentTimer: null == currentTimer
          ? _value.currentTimer
          : currentTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      assistTimer: null == assistTimer
          ? _value.assistTimer
          : assistTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      bonusTimer: null == bonusTimer
          ? _value.bonusTimer
          : bonusTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClockImplCopyWith<$Res> implements $ClockCopyWith<$Res> {
  factory _$$ClockImplCopyWith(
          _$ClockImpl value, $Res Function(_$ClockImpl) then) =
      __$$ClockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration currentTimer,
      Duration assistTimer,
      Duration bonusTimer,
      TimerStatus status});
}

/// @nodoc
class __$$ClockImplCopyWithImpl<$Res>
    extends _$ClockCopyWithImpl<$Res, _$ClockImpl>
    implements _$$ClockImplCopyWith<$Res> {
  __$$ClockImplCopyWithImpl(
      _$ClockImpl _value, $Res Function(_$ClockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTimer = null,
    Object? assistTimer = null,
    Object? bonusTimer = null,
    Object? status = null,
  }) {
    return _then(_$ClockImpl(
      currentTimer: null == currentTimer
          ? _value.currentTimer
          : currentTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      assistTimer: null == assistTimer
          ? _value.assistTimer
          : assistTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      bonusTimer: null == bonusTimer
          ? _value.bonusTimer
          : bonusTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
    ));
  }
}

/// @nodoc

class _$ClockImpl implements _Clock {
  _$ClockImpl(
      {required this.currentTimer,
      required this.assistTimer,
      required this.bonusTimer,
      required this.status});

  @override
  final Duration currentTimer;
  @override
  final Duration assistTimer;
  @override
  final Duration bonusTimer;
  @override
  final TimerStatus status;

  @override
  String toString() {
    return 'Clock(currentTimer: $currentTimer, assistTimer: $assistTimer, bonusTimer: $bonusTimer, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClockImpl &&
            (identical(other.currentTimer, currentTimer) ||
                other.currentTimer == currentTimer) &&
            (identical(other.assistTimer, assistTimer) ||
                other.assistTimer == assistTimer) &&
            (identical(other.bonusTimer, bonusTimer) ||
                other.bonusTimer == bonusTimer) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentTimer, assistTimer, bonusTimer, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClockImplCopyWith<_$ClockImpl> get copyWith =>
      __$$ClockImplCopyWithImpl<_$ClockImpl>(this, _$identity);
}

abstract class _Clock implements Clock {
  factory _Clock(
      {required final Duration currentTimer,
      required final Duration assistTimer,
      required final Duration bonusTimer,
      required final TimerStatus status}) = _$ClockImpl;

  @override
  Duration get currentTimer;
  @override
  Duration get assistTimer;
  @override
  Duration get bonusTimer;
  @override
  TimerStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$ClockImplCopyWith<_$ClockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
