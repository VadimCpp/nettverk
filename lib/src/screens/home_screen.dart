import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nettverk/src/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            OverlappingImages(
              imagePaths: [
                'assets/images/bergen_logo.png',
                'assets/images/borinorge_logo.png',
                'assets/images/oslo_logo.png',
              ],
            ),
            SizedBox(height: 10),
            // Welcome Message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.welcomeMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // Instruction text
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.chooseSection,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // Quick Links
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.chat),
                    label: Text(AppLocalizations.of(context)!.chats),
                    onPressed: () {
                      context.push('/chats');
                    },
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.assistant),
                    label: Text(AppLocalizations.of(context)!.botassistant),
                    onPressed: () {
                      context.push('/bot');
                    },
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.school),
                    label: Text(AppLocalizations.of(context)!.education),
                    onPressed: () {
                      context.push('/edu');
                    },
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.info),
                    label: Text(AppLocalizations.of(context)!.aboutUs),
                    onPressed: () {
                      context.push('/about');
                    },
                  ),
                  // Add more quick links as needed
                ],
              ),
            ),
            SizedBox(height: 20),
            LatestNews()
          ],
        ),
      ),
    );
  }
}
