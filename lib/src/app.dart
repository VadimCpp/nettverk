import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nettverk/src/controllers/index.dart';
import 'package:nettverk/src/screens/index.dart';

class NettverkApp extends StatelessWidget {
  const NettverkApp({super.key});

  void onComponentFullyLoaded() {
    debugPrint("App is fully loaded!");
    Future.delayed(const Duration(seconds: 1), () {
      debugPrint("Hide splash screen");
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    // Run the method after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onComponentFullyLoaded();
    });

    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('nb', ''), // Norsk Bokmål, no country code
        Locale('nn', ''), // Norsk Nynorsk, no country code
        Locale('uk', ''), // Ukrainian, no country code
        Locale('en', ''), // English, no country code
        Locale('ru', ''), // Russian, no country code
        Locale('pl', ''), // Polish, no country code
      ],

      // Hide the debug banner in debug mode
      debugShowCheckedModeBanner: false,

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,

      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: settingsController.themeMode,

      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SettingsScreen.routeName:
                return SettingsScreen(controller: settingsController);
              case ChatScreen.routeName:
                return const ChatScreen();
              case HomeScreen.routeName:
              default:
                return const HomeScreen();
            }
          },
        );
      },
    );
  }
}