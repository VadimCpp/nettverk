import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nettverk/src/controllers/index.dart';
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
    try {
      if (await launchUrl(telegramAppUrl)) {
        isLaunched = true;
      }
    }
    catch (e) {
      isLaunched = false;
    }

    if (!isLaunched) {
      showDialog(
        barrierDismissible: false, // User must tap a button to dismiss
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(AppLocalizations.of(context)!.openTelergamAppErrorMessage),
            actions: [
              TextButton(
                child: const Text("OK"),
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
            const SizedBox(height: 20),
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
                      child: GestureDetector(
                        onTap: () {
                          _openTelegram(context, chat.chatName!);
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter, // Align text at the bottom center of the image
                          children: [
                            Container(
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
                            Container(
                              width: double.infinity,
                              // Add a semi-transparent background for better text visibility and the border radius at the bottom
                              padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ), 
                                color: Colors.black.withOpacity(0.5),
                                ),
                              child: Text(
                                '${AppLocalizations.of(context)!.telegramChat} - ${chat.title}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ), 
                            ),
                          ],
                        ),
                      ),
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
