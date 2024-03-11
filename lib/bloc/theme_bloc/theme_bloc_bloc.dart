import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/app/app_theme.dart';
import 'package:github_test_app/data/local_storage/shared_preferences.dart';

part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  // Initial state is light theme
  ThemeBloc() : super(ThemeData.light()) {
    // Listen for initial theme set event
    on<InitialThemeSetEvent>((event, emit) async {
      // Try to get theme preference from SharedPrefs
      final themeData = await getThemeFromSharedPrefs();
      if (themeData != null) {
        // Emit retrieved theme if found
        emit(themeData);
      } else {
        // Default to light theme if no preference found
        emit(ThemeData.light());
      }
    });

    // Listen for theme switch event
    on<ThemeSwitchEvent>((event, emit) {
      // Get new theme based on current state
      final newTheme = state == AppTheme.darkTheme
          ? AppTheme.lightTheme
          : AppTheme.darkTheme;
      // Emit the new theme
      emit(newTheme);
      // Save the new theme to SharedPrefs
      setTheme(newTheme);
    });
  }

  // Function to retrieve theme preference from SharedPrefs
  Future<ThemeData?> getThemeFromSharedPrefs() async {
    // Get SharedPreferences instance
    final prefs = SharedPreferencesManager.instance;
    // Check if dark mode preference exists
    final isDark = await prefs.getBool(SharedPrefsKeys.isDark);
    // Return appropriate theme based on preference, otherwise null
    return isDark != null
        ? (isDark ? AppTheme.darkTheme : AppTheme.lightTheme)
        : null;
  }

  // Function to save theme preference to SharedPrefs
  Future<void> setTheme(ThemeData theme) async {
    // Get SharedPreferences instance
    final prefs = SharedPreferencesManager.instance;
    // Save a boolean indicating dark theme based on input theme
    await prefs.setBool(SharedPrefsKeys.isDark, theme == AppTheme.darkTheme);
  }
}
