import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sample_item.dart';
import 'about_us_view.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  Future<void> _openTelegram(String chatName) async {
    final Uri telegramAppUrl = Uri.parse('tg://resolve?domain=$chatName'); // For Telegram app
    final Uri telegramWebUrl = Uri.parse('https://t.me/$chatName'); // Fallback for browser

    if (await canLaunchUrl(telegramAppUrl)) {
      await launchUrl(telegramAppUrl, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(telegramWebUrl)) {
      await launchUrl(telegramWebUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Telegram chat.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Deserialize the arguments back to a SampleItem
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final SampleItem item = SampleItem.fromMap(args);
    
    Widget body = Center(
      child: Text(AppLocalizations.of(context)!.helloWorld,
        style: const TextStyle(fontSize: 36),
      ),
    );
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
              "We use Telegram to communicate with our members. Join our chat to stay updated!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _openTelegram(item.chatName!);
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
