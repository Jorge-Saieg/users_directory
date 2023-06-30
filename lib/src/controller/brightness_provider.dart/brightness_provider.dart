import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:users_directory/src/controller/brightness_provider.dart/brightness_state.dart';
import 'package:users_directory/src/controller/brightness_provider.dart/brightness_state_notifier.dart';

///Dependency Injection

//* Logic / StateNotifier
final brightnessNotifierProvider =
    StateNotifierProvider<BrightnessNotifier, BrightnessState>((ref) => BrightnessNotifier());
