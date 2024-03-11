import 'package:flutter/material.dart';

// This class defines two ThemeData objects for light and dark themes of an app.

class AppTheme {
  // Defines a ThemeData object for the dark theme of the app.
  static final ThemeData darkTheme = ThemeData(
    // Enables Material Design 3 theming system.
    useMaterial3: true,
    // Sets the background color of the app scaffold (main layout) to a dark grey.
    scaffoldBackgroundColor: Colors.grey[900],

    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      primaryContainer: Colors.grey[300],
    ),
  );

  // Defines a ThemeData object for the light theme of the app.
  static final ThemeData lightTheme = ThemeData(
    // Enables Material Design 3 theming system.
    useMaterial3: true,
    // Sets the background color of the app scaffold (main layout) to white.
    scaffoldBackgroundColor: Colors.white,

    colorScheme: ColorScheme.light(
      primary: Colors.white,
      primaryContainer: Colors.grey[500],
    ),
  );
}
