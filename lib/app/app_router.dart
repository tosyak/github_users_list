import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:github_test_app/presentation/no_network_screen.dart';
import 'package:github_test_app/presentation/not_found_screen.dart';
import 'package:github_test_app/presentation/settings_screen.dart';
import 'package:github_test_app/presentation/splash_screen.dart';
import 'package:github_test_app/presentation/user_details_screen.dart';
import 'package:github_test_app/presentation/users_list_screen.dart';

// This class defines a router for a mobile application.
// It utilizes the go_router package to manage navigation.
class AppRouter {
  // A global key for the root navigator, used to access the navigation state
  // and control navigation throughout the app.
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  // The GoRouter instance that handles navigation.
  static final GoRouter _router = GoRouter(
    // The key for the root navigator.
    navigatorKey: _rootNavigatorKey,

    // The initial route to display when the app starts.
    initialLocation: PAGES.splash.screenPath,

    // An array of GoRoute objects defining available routes.
    routes: [
      // Route for the splash screen.
      GoRoute(
        path: PAGES.splash.screenPath, // Path for the splash screen.
        name: PAGES.splash.screenName, // Name for the splash screen route.
        builder: (context, state) =>
            const SplashScreen(), // Builds the splash screen.
      ),

      // Route for the no network screen.
      GoRoute(
        path: PAGES.noNetwork.screenPath,
        name: PAGES.noNetwork.screenName,
        builder: (context, state) => const NoNetworkScreen(),
      ),

      // Route for the settings screen.
      GoRoute(
        path: PAGES.settings.screenPath,
        name: PAGES.settings.screenName,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Route for the users list screen, with a nested route for user details.
      GoRoute(
        path: PAGES.usersList.screenPath,
        name: PAGES.usersList.screenName,
        builder: (context, state) => const UsersListScreen(),
        routes: [
          GoRoute(
            path: PAGES.userDetails.screenPath,
            name: PAGES.userDetails.screenName,
            builder: (context, state) => const UserDetailsScreen(),
          ),
        ],
      ),
    ],

    // A widget to display when an unexpected error occurs during navigation.
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  // Getter to access the instantiated GoRouter object.
  static GoRouter get router => _router;
}

// An enum to define the different pages in the application.
enum PAGES {
  splash,
  usersList,
  userDetails,
  noNetwork,
  settings,
}

// Extension method for PAGES enum to generate screen paths and names dynamically.
extension AppPageExtension on PAGES {
  // Generates the screen path based on the enum value.
  String get screenPath {
    switch (this) {
      case PAGES.splash:
        return "/";
      case PAGES.usersList:
        return "/usersList";
      case PAGES.userDetails:
        return "usersDetails";
      case PAGES.noNetwork:
        return "/noNetwork";
      case PAGES.settings:
        return "/settings";
      default:
        return "/"; // Handle cases not explicitly defined.
    }
  }

  // Generates the screen name based on the enum value.
  String get screenName {
    switch (this) {
      case PAGES.splash:
        return "splash";
      case PAGES.usersList:
        return "usersList";
      case PAGES.userDetails:
        return "usersDetails";
      case PAGES.noNetwork:
        return "noNetwork";
      case PAGES.settings:
        return "settings";
      default:
        return "/"; // Handle cases not explicitly defined.
    }
  }
}
