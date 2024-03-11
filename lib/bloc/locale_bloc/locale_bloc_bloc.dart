import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_test_app/data/local_storage/shared_preferences.dart';

part 'locale_bloc_event.dart';
part 'locale_bloc_state.dart';

class LocaleBloc extends Bloc<LocaleBlocEvent, LocaleBlocState> {
  // Injects a SharedPreferencesManager for persistent storage of locale preference
  final SharedPreferencesManager prefs;

  LocaleBloc(this.prefs) : super(LocaleBlocInitialState()) {
    // Handles the initial setup of locale
    on<LocaleBlocInitialEvent>((event, emit) async {
      // Retrieves stored boolean preference indicating Russian locale
      final bool isRuLocale =
          await prefs.getBool(SharedPrefsKeys.isRu) ?? false;

      // Emits appropriate state based on stored preference or default to English
      if (isRuLocale) {
        emit(const LocaleBlocSwitchedState(Locale('ru')));
      } else {
        emit(const LocaleBlocSwitchedState(Locale('en')));
      }
    });

    // Handles locale switching events
    on<LocaleBlocSwitchEvent>((event, emit) async {
      // Updates preference and emits state for Russian locale
      if (event.locale.languageCode == 'ru') {
        await prefs.setBool(SharedPrefsKeys.isRu, true);
        emit(const LocaleBlocSwitchedState(Locale('ru')));

        // Updates preference and emits state for English locale
      } else if (event.locale.languageCode == 'en') {
        await prefs.setBool(SharedPrefsKeys.isRu, false);
        emit(const LocaleBlocSwitchedState(Locale('en')));
      }
    });
  }
}
