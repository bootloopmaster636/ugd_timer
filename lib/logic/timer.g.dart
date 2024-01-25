// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerLogicHash() => r'85753ae3a8dabb4ef53f590e7beef4504d31cd5f';

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
String _$timerBeatHash() => r'b2ad584dc9c95f8347f7f2bff38a74c20239dbcf';

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
