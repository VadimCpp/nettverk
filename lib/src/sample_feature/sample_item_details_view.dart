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
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: body,
    );
  }
}
