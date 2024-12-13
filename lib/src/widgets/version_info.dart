import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          final version = snapshot.data!.version;
          final buildNumber = snapshot.data!.buildNumber;
          return Text("${AppLocalizations.of(context)!.version}: $version ($buildNumber)");
        }
        return Text(AppLocalizations.of(context)!.versionIsNotAvailable);
      },
    );
  }
}
