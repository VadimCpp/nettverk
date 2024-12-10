import 'package:flutter/material.dart';
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
            title: const Text('Settings'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme selection dropdown.
                DropdownButton<ThemeMode>(
                  value: settingsController.themeMode,
                  onChanged: settingsController.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Theme'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Language selection dropdown.
                DropdownButton<Locale?>(
                  value: settingsController.locale,
                  onChanged: settingsController.updateLocale,
                  items: const [
                    DropdownMenuItem(
                      value: null,
                      child: Text('System Language'),
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
                      child: Text('Ukrainian'),
                    ),
                    DropdownMenuItem(
                      value: Locale('en', ''),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('ru', ''),
                      child: Text('Russian'),
                    ),
                    DropdownMenuItem(
                      value: Locale('pl', ''),
                      child: Text('Polish'),
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
