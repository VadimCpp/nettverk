import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nettverk/src/components/index.dart';
import 'package:nettverk/src/controllers/index.dart';
import 'package:nettverk/src/models/index.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  late List<Chat> items;

  @override
  void initState() {
    super.initState();
    final itemsController = Provider.of<ItemsController>(context, listen: false);
    items = itemsController.items();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutUs),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 270.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: items.map((chat) => Center(
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
                          chat.title,
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
                )
                )
              ).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              AppLocalizations.of(context)!.aboutNettverk,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 20),
          VersionInfo(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text(AppLocalizations.of(context)!.back),
          ),
        ],
      )
    );
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
}
