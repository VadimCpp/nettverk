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
            title: Text(AppLocalizations.of(context)!.appTitle),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.push('/settings');
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.welcomeMessage,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.usageInstruction,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: localizedItems.length,
                  restorationId: 'HomeScreen',
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemBuilder: (BuildContext context, int index) {
                    final item = localizedItems[index];
                    return ListTile(
                      title: Text(
                        item.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                )
              )
            ],
          ),
        );
      },
    );
  }
}
