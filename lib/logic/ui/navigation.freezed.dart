// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TopWidget {
  Widget? get currentlyShown => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopWidgetCopyWith<TopWidget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopWidgetCopyWith<$Res> {
  factory $TopWidgetCopyWith(TopWidget value, $Res Function(TopWidget) then) =
      _$TopWidgetCopyWithImpl<$Res, TopWidget>;
  @useResult
  $Res call({Widget? currentlyShown});
}

/// @nodoc
class _$TopWidgetCopyWithImpl<$Res, $Val extends TopWidget>
    implements $TopWidgetCopyWith<$Res> {
  _$TopWidgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentlyShown = freezed,
  }) {
    return _then(_value.copyWith(
      currentlyShown: freezed == currentlyShown
          ? _value.currentlyShown
          : currentlyShown // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopWidgetImplCopyWith<$Res>
    implements $TopWidgetCopyWith<$Res> {
  factory _$$TopWidgetImplCopyWith(
          _$TopWidgetImpl value, $Res Function(_$TopWidgetImpl) then) =
      __$$TopWidgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Widget? currentlyShown});
}

/// @nodoc
class __$$TopWidgetImplCopyWithImpl<$Res>
    extends _$TopWidgetCopyWithImpl<$Res, _$TopWidgetImpl>
    implements _$$TopWidgetImplCopyWith<$Res> {
  __$$TopWidgetImplCopyWithImpl(
      _$TopWidgetImpl _value, $Res Function(_$TopWidgetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentlyShown = freezed,
  }) {
    return _then(_$TopWidgetImpl(
      currentlyShown: freezed == currentlyShown
          ? _value.currentlyShown
          : currentlyShown // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }
}

/// @nodoc

class _$TopWidgetImpl implements _TopWidget {
  _$TopWidgetImpl({this.currentlyShown});

  @override
  final Widget? currentlyShown;

  @override
  String toString() {
    return 'TopWidget(currentlyShown: $currentlyShown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopWidgetImpl &&
            (identical(other.currentlyShown, currentlyShown) ||
                other.currentlyShown == currentlyShown));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentlyShown);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopWidgetImplCopyWith<_$TopWidgetImpl> get copyWith =>
      __$$TopWidgetImplCopyWithImpl<_$TopWidgetImpl>(this, _$identity);
}

abstract class _TopWidget implements TopWidget {
  factory _TopWidget({final Widget? currentlyShown}) = _$TopWidgetImpl;

  @override
  Widget? get currentlyShown;
  @override
  @JsonKey(ignore: true)
  _$$TopWidgetImplCopyWith<_$TopWidgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
