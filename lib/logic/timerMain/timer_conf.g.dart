// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_conf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimerConfImpl _$$TimerConfImplFromJson(Map<String, dynamic> json) =>
    _$TimerConfImpl(
      title: json['title'] as String,
      assistTimerEnabled: json['assistTimerEnabled'] as bool,
      bonusTimerEnabled: json['bonusTimerEnabled'] as bool,
      warningAudioPath: json['warningAudioPath'] as String,
      endAudioPath: json['endAudioPath'] as String,
      startCutoffAudioPath: json['startCutoffAudioPath'] as String,
    );

Map<String, dynamic> _$$TimerConfImplToJson(_$TimerConfImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'assistTimerEnabled': instance.assistTimerEnabled,
      'bonusTimerEnabled': instance.bonusTimerEnabled,
      'warningAudioPath': instance.warningAudioPath,
      'endAudioPath': instance.endAudioPath,
      'startCutoffAudioPath': instance.startCutoffAudioPath,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerConfLogicHash() => r'e9b6cb2d629d198766e10acfe4595067b8336994';

/// See also [TimerConfLogic].
@ProviderFor(TimerConfLogic)
final timerConfLogicProvider =
    AutoDisposeNotifierProvider<TimerConfLogic, TimerConf>.internal(
  TimerConfLogic.new,
  name: r'timerConfLogicProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timerConfLogicHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimerConfLogic = AutoDisposeNotifier<TimerConf>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
