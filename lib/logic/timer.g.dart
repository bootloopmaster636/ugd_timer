// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerLogicHash() => r'c7dda2a458bf502c20b51603d1ac18f29006d6a6';

/// See also [TimerLogic].
@ProviderFor(TimerLogic)
final timerLogicProvider =
    AutoDisposeAsyncNotifierProvider<TimerLogic, Clock>.internal(
  TimerLogic.new,
  name: r'timerLogicProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$timerLogicHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimerLogic = AutoDisposeAsyncNotifier<Clock>;
String _$timerBeatHash() => r'5340f2cf5234c58fd56f4244fe26876b0ccdafc8';

/// See also [TimerBeat].
@ProviderFor(TimerBeat)
final timerBeatProvider =
    AutoDisposeAsyncNotifierProvider<TimerBeat, TimerStatus>.internal(
  TimerBeat.new,
  name: r'timerBeatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$timerBeatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimerBeat = AutoDisposeAsyncNotifier<TimerStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
