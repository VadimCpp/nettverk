import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:nettverk/src/controllers/index.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, settingsController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.settings),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.chooseYourPreferredTheme,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Theme selection dropdown.
                DropdownButton<ThemeMode>(
                  value: settingsController.themeMode,
                  onChanged: settingsController.updateThemeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(AppLocalizations.of(context)!.systemTheme),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(AppLocalizations.of(context)!.lightTheme),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(AppLocalizations.of(context)!.darkTheme),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Text(
                  AppLocalizations.of(context)!.chooseYourPreferredLanguage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Language selection dropdown.
                DropdownButton<Locale?>(
                  value: settingsController.locale,
                  onChanged: settingsController.updateLocale,
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(AppLocalizations.of(context)!.systemLanguage),
                    ),
                    DropdownMenuItem(
                      value: Locale('nb', ''),
                      child: Text('Norsk Bokmål'),
                    ),
                    // TODO: Add support for Nynorsk
                    // DropdownMenuItem(
                    //   value: Locale('nn', ''),
                    //   child: Text('Norsk Nynorsk'),
                    // ),
                    DropdownMenuItem(
                      value: Locale('uk', ''),
                      child: Text('Українська'),
                    ),
                    DropdownMenuItem(
                      value: Locale('en', ''),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('ru', ''),
                      child: Text('Русский'),
                    ),
                    DropdownMenuItem(
                      value: Locale('pl', ''),
                      child: Text('Polski'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
