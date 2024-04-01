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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Clock _$ClockFromJson(Map<String, dynamic> json) {
  return _Clock.fromJson(json);
}

/// @nodoc
mixin _$Clock {
  Duration get mainTimer => throw _privateConstructorUsedError;
  Duration get assistTimer => throw _privateConstructorUsedError;
  Duration get bonusTimer => throw _privateConstructorUsedError;
  Duration get mainTimerFreezed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClockCopyWith<Clock> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClockCopyWith<$Res> {
  factory $ClockCopyWith(Clock value, $Res Function(Clock) then) =
      _$ClockCopyWithImpl<$Res, Clock>;
  @useResult
  $Res call(
      {Duration mainTimer,
      Duration assistTimer,
      Duration bonusTimer,
      Duration mainTimerFreezed});
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
    Object? mainTimer = null,
    Object? assistTimer = null,
    Object? bonusTimer = null,
    Object? mainTimerFreezed = null,
  }) {
    return _then(_value.copyWith(
      mainTimer: null == mainTimer
          ? _value.mainTimer
          : mainTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      assistTimer: null == assistTimer
          ? _value.assistTimer
          : assistTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      bonusTimer: null == bonusTimer
          ? _value.bonusTimer
          : bonusTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      mainTimerFreezed: null == mainTimerFreezed
          ? _value.mainTimerFreezed
          : mainTimerFreezed // ignore: cast_nullable_to_non_nullable
              as Duration,
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
      {Duration mainTimer,
      Duration assistTimer,
      Duration bonusTimer,
      Duration mainTimerFreezed});
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
    Object? mainTimer = null,
    Object? assistTimer = null,
    Object? bonusTimer = null,
    Object? mainTimerFreezed = null,
  }) {
    return _then(_$ClockImpl(
      mainTimer: null == mainTimer
          ? _value.mainTimer
          : mainTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      assistTimer: null == assistTimer
          ? _value.assistTimer
          : assistTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      bonusTimer: null == bonusTimer
          ? _value.bonusTimer
          : bonusTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      mainTimerFreezed: null == mainTimerFreezed
          ? _value.mainTimerFreezed
          : mainTimerFreezed // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClockImpl implements _Clock {
  _$ClockImpl(
      {required this.mainTimer,
      required this.assistTimer,
      required this.bonusTimer,
      this.mainTimerFreezed = Duration.zero});

  factory _$ClockImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClockImplFromJson(json);

  @override
  final Duration mainTimer;
  @override
  final Duration assistTimer;
  @override
  final Duration bonusTimer;
  @override
  @JsonKey()
  final Duration mainTimerFreezed;

  @override
  String toString() {
    return 'Clock(mainTimer: $mainTimer, assistTimer: $assistTimer, bonusTimer: $bonusTimer, mainTimerFreezed: $mainTimerFreezed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClockImpl &&
            (identical(other.mainTimer, mainTimer) ||
                other.mainTimer == mainTimer) &&
            (identical(other.assistTimer, assistTimer) ||
                other.assistTimer == assistTimer) &&
            (identical(other.bonusTimer, bonusTimer) ||
                other.bonusTimer == bonusTimer) &&
            (identical(other.mainTimerFreezed, mainTimerFreezed) ||
                other.mainTimerFreezed == mainTimerFreezed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, mainTimer, assistTimer, bonusTimer, mainTimerFreezed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClockImplCopyWith<_$ClockImpl> get copyWith =>
      __$$ClockImplCopyWithImpl<_$ClockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClockImplToJson(
      this,
    );
  }
}

abstract class _Clock implements Clock {
  factory _Clock(
      {required final Duration mainTimer,
      required final Duration assistTimer,
      required final Duration bonusTimer,
      final Duration mainTimerFreezed}) = _$ClockImpl;

  factory _Clock.fromJson(Map<String, dynamic> json) = _$ClockImpl.fromJson;

  @override
  Duration get mainTimer;
  @override
  Duration get assistTimer;
  @override
  Duration get bonusTimer;
  @override
  Duration get mainTimerFreezed;
  @override
  @JsonKey(ignore: true)
  _$$ClockImplCopyWith<_$ClockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Status {
  TimerStatus get status => throw _privateConstructorUsedError;
  DateTime get now => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatusCopyWith<Status> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCopyWith<$Res> {
  factory $StatusCopyWith(Status value, $Res Function(Status) then) =
      _$StatusCopyWithImpl<$Res, Status>;
  @useResult
  $Res call({TimerStatus status, DateTime now});
}

/// @nodoc
class _$StatusCopyWithImpl<$Res, $Val extends Status>
    implements $StatusCopyWith<$Res> {
  _$StatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? now = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
      now: null == now
          ? _value.now
          : now // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusImplCopyWith<$Res> implements $StatusCopyWith<$Res> {
  factory _$$StatusImplCopyWith(
          _$StatusImpl value, $Res Function(_$StatusImpl) then) =
      __$$StatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TimerStatus status, DateTime now});
}

/// @nodoc
class __$$StatusImplCopyWithImpl<$Res>
    extends _$StatusCopyWithImpl<$Res, _$StatusImpl>
    implements _$$StatusImplCopyWith<$Res> {
  __$$StatusImplCopyWithImpl(
      _$StatusImpl _value, $Res Function(_$StatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? now = null,
  }) {
    return _then(_$StatusImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TimerStatus,
      now: null == now
          ? _value.now
          : now // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$StatusImpl implements _Status {
  _$StatusImpl({required this.status, required this.now});

  @override
  final TimerStatus status;
  @override
  final DateTime now;

  @override
  String toString() {
    return 'Status(status: $status, now: $now)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.now, now) || other.now == now));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, now);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      __$$StatusImplCopyWithImpl<_$StatusImpl>(this, _$identity);
}

abstract class _Status implements Status {
  factory _Status(
      {required final TimerStatus status,
      required final DateTime now}) = _$StatusImpl;

  @override
  TimerStatus get status;
  @override
  DateTime get now;
  @override
  @JsonKey(ignore: true)
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
