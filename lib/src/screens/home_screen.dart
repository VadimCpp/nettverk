import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nettverk/src/models/index.dart';
import 'package:nettverk/src/screens/index.dart';

/// Displays a list of Chats.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.items = const [
      Chat(1, "Nettverk i Oslo", "assets/images/oslo_logo.png", "assets/images/ai_oslo.jpg", "oslouk"),
      Chat(2, "Nettvek i Bergen", "assets/images/bergen_logo.png", "assets/images/ai_bergen.jpg", "bergenvolonterchat"),
    ],
  });

  static const routeName = '/';

  final List<Chat> items;
  
  @override
  Widget build(BuildContext context) {
    final localizedItems = [
      ...items,
      Chat(3, AppLocalizations.of(context)!.aboutUs, "assets/images/borinorge_logo.png", null, null),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.welcome),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        itemCount: localizedItems.length,
        restorationId: 'HomeScreen',
        itemBuilder: (BuildContext context, int index) {
          final item = localizedItems[index];

          return ListTile(
            title: Text(item.title),
            leading: CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage(item.logo),
            ),
            onTap: () {
              context.push("/chat", extra: item);
            }
          );
        },
      ),
    );
  }
}
