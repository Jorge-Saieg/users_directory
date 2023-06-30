import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:users_directory/src/controller/brightness_provider.dart/brightness_state.dart';

class BrightnessNotifier extends StateNotifier<BrightnessState> {
  BrightnessNotifier() : super(const BrightnessState.initial(darkMode: false));

  Brightness _brightness = Brightness.light;
  Brightness get brightness => _brightness;

  void toggleBrightness() {
    _brightness = _brightness == Brightness.light ? Brightness.dark : Brightness.light;
    state = BrightnessState.initial(darkMode: _brightness == Brightness.dark);
  }
}
