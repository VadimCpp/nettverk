import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'sample_item.dart';
import 'about_us_view.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

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
          ElevatedButton(
            onPressed: () {
              // Navigate back to home screen
              Navigator.of(context).pop();
            },
            child: const Text('Back'),
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
