import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:nettverk/src/controllers/index.dart';
import 'package:nettverk/src/screens/index.dart';

class NettverkApp extends StatefulWidget {
  const NettverkApp({super.key});

  @override
  NettverkAppState createState() => NettverkAppState();
}

class NettverkAppState extends State<NettverkApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    // Initialize GoRouter once
    _router = GoRouter(
      initialLocation: '/',
      routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: "/settings",
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: "/chats",
            builder: (context, state) => const ChatsScreen(),
          ),
          GoRoute(
            path: "/about",
            builder: (context, state) => const AboutUsScreen(),
          ),
          GoRoute(
            path: "/education",
            builder: (context, state) => const EducationScreen(),
          ),
          GoRoute(
            path: "/bot",
            builder: (context, state) => const BotScreen(),
          )
        ],
      // Optional: Add a listener if routing logic depends on external factors
      // refreshListenable: Provider.of<SettingsController>(context, listen: false),
    );

    // Schedule the splash screen to be hidden after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onComponentFullyLoaded();
    });
  }

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

    return MaterialApp.router(
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
        // TODO: Add support for Nynorsk
        // • A MaterialLocalizations delegate that supports the nn locale was not found.
        // • A CupertinoLocalizations delegate that supports the nn locale was not found.
        // Locale('nn', ''), // Norsk Nynorsk, no country code (not supported) 
        Locale('uk', ''), // Ukrainian, no country code
        Locale('en', ''), // English, no country code
        Locale('ru', ''), // Russian, no country code
        Locale('pl', ''), // Polish, no country code
      ],
      locale: settingsController.locale,

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

      routerConfig: _router,
    );
  }
}