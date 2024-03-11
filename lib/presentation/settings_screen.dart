import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:github_test_app/app/app_theme.dart';
import 'package:github_test_app/bloc/locale_bloc/locale_bloc_bloc.dart';
import 'package:github_test_app/bloc/theme_bloc/theme_bloc_bloc.dart';
import 'package:github_test_app/data/local_storage/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _setLocale();
  }

  void _setLanguage(String? newLanguage) {
    setState(() {
      _selectedLanguage = newLanguage ?? _selectedLanguage;
    });
  }

  void _setLocale() async {
    final prefs = SharedPreferencesManager.instance;
    final bool? isRuLocale = await prefs.getBool(SharedPrefsKeys.isRu);
    if (isRuLocale != null) {
      _selectedLanguage = isRuLocale ? 'Русский' : 'English';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.appTheme),
                BlocBuilder<ThemeBloc, ThemeData>(
                  builder: (context, themeData) {
                    return Switch(
                      value: themeData == AppTheme.darkTheme,
                      onChanged: (bool val) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ThemeSwitchEvent());
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.language),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: [
                    DropdownMenuItem(
                      value: 'English',
                      child: const Text('English'),
                      onTap: () => context
                          .read<LocaleBloc>()
                          .add(const LocaleBlocSwitchEvent(Locale('en'))),
                    ),
                    DropdownMenuItem(
                      value: 'Русский',
                      child: const Text('Русский'),
                      onTap: () => context
                          .read<LocaleBloc>()
                          .add(const LocaleBlocSwitchEvent(Locale('ru'))),
                    ),
                  ],
                  onChanged: _setLanguage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
