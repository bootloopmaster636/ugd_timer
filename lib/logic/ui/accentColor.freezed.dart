// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accentColor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccentColor {
  Color get accentColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccentColorCopyWith<AccentColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccentColorCopyWith<$Res> {
  factory $AccentColorCopyWith(
          AccentColor value, $Res Function(AccentColor) then) =
      _$AccentColorCopyWithImpl<$Res, AccentColor>;
  @useResult
  $Res call({Color accentColor});
}

/// @nodoc
class _$AccentColorCopyWithImpl<$Res, $Val extends AccentColor>
    implements $AccentColorCopyWith<$Res> {
  _$AccentColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accentColor = freezed,
  }) {
    return _then(_value.copyWith(
      accentColor: freezed == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccentColorImplCopyWith<$Res>
    implements $AccentColorCopyWith<$Res> {
  factory _$$AccentColorImplCopyWith(
          _$AccentColorImpl value, $Res Function(_$AccentColorImpl) then) =
      __$$AccentColorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color accentColor});
}

/// @nodoc
class __$$AccentColorImplCopyWithImpl<$Res>
    extends _$AccentColorCopyWithImpl<$Res, _$AccentColorImpl>
    implements _$$AccentColorImplCopyWith<$Res> {
  __$$AccentColorImplCopyWithImpl(
      _$AccentColorImpl _value, $Res Function(_$AccentColorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accentColor = freezed,
  }) {
    return _then(_$AccentColorImpl(
      accentColor: freezed == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$AccentColorImpl implements _AccentColor {
  _$AccentColorImpl({required this.accentColor});

  @override
  final Color accentColor;

  @override
  String toString() {
    return 'AccentColor(accentColor: $accentColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccentColorImpl &&
            const DeepCollectionEquality()
                .equals(other.accentColor, accentColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(accentColor));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccentColorImplCopyWith<_$AccentColorImpl> get copyWith =>
      __$$AccentColorImplCopyWithImpl<_$AccentColorImpl>(this, _$identity);
}

abstract class _AccentColor implements AccentColor {
  factory _AccentColor({required final Color accentColor}) = _$AccentColorImpl;

  @override
  Color get accentColor;
  @override
  @JsonKey(ignore: true)
  _$$AccentColorImplCopyWith<_$AccentColorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
