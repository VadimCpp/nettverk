import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nettverk/src/controllers/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nettverk/src/models/index.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});
  
  @override
  ChatsScreenState createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen> {
  late List<Chat> items;

  @override
  void initState() {
    super.initState();
    final itemsController = Provider.of<ItemsController>(context, listen: false);
    items = itemsController.items();
  }

  Future<void> _openTelegram(BuildContext context, String chatName) async {
    final Uri telegramAppUrl = Uri.parse('tg://resolve?domain=$chatName'); // For Telegram app is required

    bool isLaunched = false;
    String errorMessage = 'Error launching Telegram chat';
    try {
      if (await launchUrl(telegramAppUrl)) {
        isLaunched = true;
      }
    }
    catch (e) {
      errorMessage = 'Error launching Telegram app: $e';
      isLaunched = false;
    }

    if (!isLaunched) {
      showDialog(
        barrierDismissible: false, // User must tap a button to dismiss
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chats),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                AppLocalizations.of(context)!.joinTelegramChat,
                textAlign: TextAlign.left,
              ),
            ),
            ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final chat = items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        width: double.infinity,
                        height: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
                        ),
                        clipBehavior: Clip.antiAlias, // Ensure the image is clipped to the border radius
                        child: Image.asset(
                          chat.picture!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _openTelegram(context, chat.chatName!);
                      },
                      child: Text('Telegram chat - ${chat.title}'),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            )
          ],
        ),
      )
    );
  }
}
