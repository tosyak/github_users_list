import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:github_test_app/app/app_router.dart';
import 'package:github_test_app/bloc/app_initializer_bloc/app_initializer_bloc_bloc.dart';
import 'package:github_test_app/bloc/locale_bloc/locale_bloc_bloc.dart';
import 'package:github_test_app/bloc/splash_bloc/splash_bloc_bloc.dart';
import 'package:github_test_app/bloc/theme_bloc/theme_bloc_bloc.dart';
import 'package:github_test_app/bloc/user_details_bloc/user_details_bloc_bloc.dart';
import 'package:github_test_app/bloc/users_list_bloc/users_list_bloc_bloc.dart';
import 'package:github_test_app/data/network/api_service.dart';
import 'package:github_test_app/data/repository/api_repository.dart';
import 'package:github_test_app/data/local_storage/shared_preferences.dart';
import 'package:github_test_app/presentation/users_list_screen.dart';

void main() async {
  // Ensure widgets are ready for rendering
  WidgetsFlutterBinding.ensureInitialized();

  // Wait for shared preferences to be initialized
  await SharedPreferencesManager.instance.initialize();

  // Launch the application with the MyApp widget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access shared preferences instance
    final sharedPrefManager = SharedPreferencesManager.instance;

    // Create an API service instance
    final ApiService apiService = ApiService();

    return MultiBlocProvider(
      // List of BlocProviders for managing application state
      providers: [
        BlocProvider(
          create: (context) => AppInitializationBloc(sharedPrefManager)
            ..add(const AppInitializationEvent()),
          child: const SizedBox.shrink(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(InitialThemeSetEvent()),
        ),
        BlocProvider(
          create: (context) =>
              LocaleBloc(sharedPrefManager)..add(LocaleBlocInitialEvent()),
        ),
        BlocProvider(
          create: (context) => SplashBloc()..add(const SplashCheck()),
          child: const UsersListScreen(),
        ),
        BlocProvider(
          create: (context) =>
              UsersListBloc(UsersListRepository(apiService: apiService))
                ..add(GetUsersEvent()),
          child: const UsersListScreen(),
        ),
        BlocProvider(
          create: (context) =>
              UserDetailsBloc(UserDetailsRepository(apiService: apiService)),
        ),
      ],
      child: Builder(
        // Access Bloc states within the build context
        builder: (BuildContext context) {
          // Default locale
          Locale locale = const Locale('en');

          // Get theme state
          final ThemeBloc themeBloc = context.watch<ThemeBloc>();

          // Get locale state (if available)
          final langBlocState = context.watch<LocaleBloc>().state;
          if (langBlocState is LocaleBlocSwitchedState) {
            locale = langBlocState.localeCode;
          }

          // Build the MaterialApp based on AppInitializationBloc state
          return BlocBuilder<AppInitializationBloc, AppState>(
            builder: (context, state) {
              if (state is AppInitializerStateInitialized) {
                // App is ready - display MaterialApp
                return MaterialApp.router(
                  builder: (context, child) {
                    return MediaQuery(
                      // Prevent text scaling issues
                      data: MediaQuery.of(context).copyWith(
                        textScaler: TextScaler.noScaling,
                      ),
                      child: child ?? const SizedBox.shrink(),
                    );
                  },
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  routeInformationProvider:
                      AppRouter.router.routeInformationProvider,
                  routeInformationParser:
                      AppRouter.router.routeInformationParser,
                  routerDelegate: AppRouter.router.routerDelegate,
                  title: 'Flutter GitHub Demo',
                  theme: themeBloc.state,
                  locale: locale,
                );
              } else {
                // App is initializing - display a placeholder
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
