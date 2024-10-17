import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sample_item.dart';
import 'about_us_view.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  Future<void> _openTelegram(BuildContext context, String chatName) async {
    final Uri telegramAppUrl = Uri.parse('tg://resolve?domain=$chatName'); // For Telegram app
    final Uri telegramWebUrl = Uri.parse('https://t.me/$chatName'); // Fallback for browser

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
      try {
        if (await launchUrl(telegramWebUrl)) {
          isLaunched = true;
        }
      }
      catch (e) {
        errorMessage = 'Error launching Telegram website: $e';
        isLaunched = false;
      }
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
                  Navigator.of(context).pop();
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
    // Deserialize the arguments back to a SampleItem
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final SampleItem item = SampleItem.fromMap(args);
    
    Widget body;
    if (item.id == 3) {
      body = const AboutUsView();
    } else {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Image.asset(
              item.picture!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              AppLocalizations.of(context)!.joinTelegramChat,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _openTelegram(context, item.chatName!);
            },
            child: const Text('Telegram chat'),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: body,
    );
  }
}
