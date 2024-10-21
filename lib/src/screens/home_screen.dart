import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nettverk/src/controllers/index.dart';

/// Displays a list of Chats.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsController>(
      builder: (context, itemsController, child) {
        final localizedItems = itemsController.items(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.welcome),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.push('settings');
                },
              ),
            ],
          ),
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
                  if (item.id == 3) {
                    context.push("/about");
                  } else {
                    context.push("/chat", extra: item);
                  }
                }
              );
            },
          ),
        );
      },
    );
  }
}
