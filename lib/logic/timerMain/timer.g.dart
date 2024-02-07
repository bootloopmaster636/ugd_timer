// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerLogicHash() => r'f46a158f22a20c7ece70d261e8cde47253cbcc08';

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
String _$timerBeatHash() => r'36d4503dfaff76e93ec03192fed95ad3cc7fba69';

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
