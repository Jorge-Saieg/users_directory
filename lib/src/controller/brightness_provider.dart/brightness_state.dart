import 'package:freezed_annotation/freezed_annotation.dart';

part 'brightness_state.freezed.dart';

@freezed
abstract class BrightnessState with _$BrightnessState {
  const factory BrightnessState.initial({required bool darkMode}) = _Initial;

  const factory BrightnessState.loading() = _Loading;

  const factory BrightnessState.error(String message) = _Error;
}
