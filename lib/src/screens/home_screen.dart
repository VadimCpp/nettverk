import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<RssFeed> _feed;

  @override
  void initState() {
    super.initState();
    _feed = fetchFeed();
  }

  Future<RssFeed> fetchFeed() async {
    final response = await http.get(Uri.parse('https://borinorge.no/rss')); // Replace with actual RSS feed URL
    if (response.statusCode == 200) {
      return RssFeed.parse(response.body);
    } else {
      return RssFeed.parse("""
        <?xml version="1.0" encoding="UTF-8" ?>
        <rss version="2.0">
          <channel>
            <title>Vi bor i Norge - Prosjekter</title>
            <description>En oversikt over prosjektene på Vi bor i Norge, en nettside for integrering i Norge.</description>
            <link>https://www.borinorge.no/</link>
            <language>no</language>
            <pubDate>Sun, 10 Dec 2024 12:00:00 GMT</pubDate>
            
            <item>
              <title>Початок проєкту "Nettverk"</title>
              <description>
                Nettverk er et vennlig samfunn i Norge som hjelper nye innbyggere med å integrere seg i samfunnet. Del erfaringer, få nye venner, og bidra til gjensidig forståelse mellom kulturer.
                Vi oppmuntrer til respekt og støtter hverandre i vanskelige situasjoner.
              </description>
              <link>https://borinorge.no/projects/nettverk</link>
              <pubDate>Sun, 01 Dec 2024 11:00:00 GMT</pubDate>
            </item>
            
            <item>
              <title>Волонтери зібрали матеріали для вивчення норвезької мови</title>
              <description>
                Lær norsk lett tilbyr de beste språklæringsressursene, inkludert lesing, lytting, skriving og muntlig praksis for nivåene A1, A2, B1, og B2. 
                Totalt 14 ressurser er tilgjengelige, inkludert LearnNoW, Norskappen, og Klar Tale.
              </description>
              <link>https://borinorge.no/norsklett</link>
              <pubDate>Fri, 17 May 2024 19:00:00 GMT</pubDate>
            </item>
            
            <item>
              <title>Сайт Ordbøkene перекладено українскою мовою</title>
              <description>
                Bokmålsordboka og Nynorskordboka er standardordbøkene i Norge, tilgjengelige som nettsider og apper. 
                I 2024 ble en ukrainsk oversettelse av brukergrensesnittet lansert, et innovativt prosjekt utført av et dedikert team med støtte fra Universitetet i Bergen og Språkrådet.
              </description>
              <link>https://borinorge.no/projects/ordbokene</link>
              <pubDate>Thu, 24 Aug 2023 12:00:00 GMT</pubDate>
            </item>
          </channel>
        </rss>
        """);
      // TODO: Handle error if feed fails to load
      // throw Exception('Failed to load feed');
    }
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
            // Latest News Feed
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.latestNews,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0),
              child: FutureBuilder<RssFeed>(
                future: _feed,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!.items!;
                    return ListView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item.title ?? ''),
                          subtitle: Text(
                            item.pubDate != null 
                              ? DateFormat.yMMMMd(Localizations.localeOf(context).toString())
                                .format(item.pubDate!)
                              : '',
                          ),
                          onTap: () => _onTap(item)
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        AppLocalizations.of(context)!.feedLoadError,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTap(item) async {
    if (item.link != null) {
      final url = Uri.parse(item.link!);

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.cannotLaunchUrl)),
          );
        }
      }
    }
  }
}
