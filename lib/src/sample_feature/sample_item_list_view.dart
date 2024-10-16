import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [
      SampleItem(1, "Nettverk i Oslo", "assets/images/oslo_logo.png"),
      SampleItem(2, "Nettvek i Bergen", "assets/images/bergen_logo.png"),
    ],
  });

  static const routeName = '/';

  final List<SampleItem> items;
  
  @override
  Widget build(BuildContext context) {
    final localizedItems = [
      ...items,
      SampleItem(3, AppLocalizations.of(context)!.aboutUs, "assets/images/borinorge_logo.png"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
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
        restorationId: 'sampleItemListView',
        itemBuilder: (BuildContext context, int index) {
          final item = localizedItems[index];

          return ListTile(
            title: Text(item.title),
            leading: CircleAvatar(
              // Display the Flutter Logo image asset.
              foregroundImage: AssetImage(item.logo),
            ),
            onTap: () {
              // Navigate to the details page. If the user leaves and returns to
              // the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(
                context,
                SampleItemDetailsView.routeName,
                arguments: item.toMap(),
              );
            }
          );
        },
      ),
    );
  }
}
