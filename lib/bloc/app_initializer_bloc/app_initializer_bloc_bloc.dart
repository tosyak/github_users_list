import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_test_app/data/local_storage/shared_preferences.dart';
import 'package:github_test_app/utils/logger.dart';

part 'app_initializer_bloc_event.dart';
part 'app_initializer_bloc_state.dart';

class AppInitializationBloc extends Bloc<AppInitializationEvent, AppState> {
  // Inject SharedPreferencesManager for accessing app preferences
  final SharedPreferencesManager prefs;

  AppInitializationBloc(this.prefs) : super(AppInitializerStateInitial()) {
    // Handle incoming AppInitializationEvent events
    on<AppInitializationEvent>((event, emit) async {
      try {
        // Check if it's the app's first start
        final bool isFirstStart =
            await prefs.getBool(SharedPrefsKeys.firstStart) ?? true;

        if (isFirstStart) {
          // Mark first start as complete in preferences
          await prefs.setBool(SharedPrefsKeys.firstStart, false);

          // Store system language preference if it's Russian
          final String systemLanguage = Platform.localeName.substring(0, 2);
          if (systemLanguage == 'ru') {
            await prefs.setBool(SharedPrefsKeys.isRu, true);
          }

          // Store system brightness preference if it's dark mode
          final Brightness systemBrightness =
              WidgetsBinding.instance.platformDispatcher.platformBrightness;
          if (systemBrightness == Brightness.dark) {
            await prefs.setBool(SharedPrefsKeys.isDark, true);
          }
        }

        // Emit initialized state to signal completion
        emit(AppInitializerStateInitialized());
      } catch (error) {
        // Handle any errors during initialization (replace with appropriate error handling)
        logger.e('Error during initialization: $error');
      }
    });
  }
}
