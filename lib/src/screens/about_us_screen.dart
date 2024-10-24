import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutUs),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              AppLocalizations.of(context)!.aboutNettverk,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 40),
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
}
