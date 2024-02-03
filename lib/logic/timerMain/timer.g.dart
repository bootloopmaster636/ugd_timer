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
String _$timerBeatHash() => r'88aae035d5d63dac95fdd47f0d7cb5655955d2dd';

/// See also [TimerBeat].
@ProviderFor(TimerBeat)
final timerBeatProvider =
    AutoDisposeAsyncNotifierProvider<TimerBeat, Status>.internal(
  TimerBeat.new,
  name: r'timerBeatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$timerBeatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimerBeat = AutoDisposeAsyncNotifier<Status>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
