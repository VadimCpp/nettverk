import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:nettverk/src/services/index.dart';
import 'package:nettverk/src/controllers/index.dart';

import 'src/app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Set up the ItemsController, which will glue the list of items to multiple
  // Flutter Widgets.
  final itemsController = ItemsController();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsController>(
          create: (context) => settingsController,
        ),
        ChangeNotifierProvider<ItemsController>(
          create: (context) => itemsController,
        ),
      ],
      child: const NettverkApp(),
    ),
  );
}
