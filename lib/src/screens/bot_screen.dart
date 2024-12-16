import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});
  
  @override
  BotScreenState createState() => BotScreenState();
}

class BotScreenState extends State<BotScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.botassistant),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Stack(
                alignment: Alignment.bottomCenter, // Align text at the bottom center of the image
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
                    ),
                    clipBehavior: Clip.antiAlias, // Ensure the image is clipped to the border radius
                    child: Image.asset(
                      'assets/images/bot.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // NOTE! The following code is commented out because it is not needed for this example
                  // Container(
                  //   width: double.infinity,
                  //   // Add a semi-transparent background for better text visibility and the border radius at the bottom
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //     decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.only(
                  //       bottomLeft: Radius.circular(8),
                  //       bottomRight: Radius.circular(8),
                  //     ), 
                  //     color: Colors.black.withOpacity(0.5),
                  //     ),
                  //   child: Text(
                  //     '...',
                  //     textAlign: TextAlign.center,
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ), 
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                AppLocalizations.of(context)!.botPromo,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.chat),
              label: Text(AppLocalizations.of(context)!.chats),
              onPressed: () {
                context.push('/chats');
              },
            ),
          ],
        ),
      )
    );
  }
}
