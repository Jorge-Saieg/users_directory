import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:users_directory/src/view/home_screen.dart';
import 'package:users_directory/src/controller/brightness_provider.dart/brightness_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(brightnessNotifierProvider);
    return state.maybeWhen(
        initial: (value) => MaterialApp(
              title: 'Users Directory',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF70D3E3), brightness: value ? Brightness.dark : Brightness.light),
                fontFamily: GoogleFonts.poppins().fontFamily,
                useMaterial3: true,
              ),
              home: const HomeScreen(),
            ),
        orElse: () => Container());
  }
}
