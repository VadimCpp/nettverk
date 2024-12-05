import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed_revised/webfeed_revised.dart';
import 'package:nettverk/src/controllers/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              <title>Nettverk</title>
              <description>
                Nettverk er et vennlig samfunn i Norge som hjelper nye innbyggere med å integrere seg i samfunnet. Del erfaringer, få nye venner, og bidra til gjensidig forståelse mellom kulturer.
                Vi oppmuntrer til respekt og støtter hverandre i vanskelige situasjoner.
              </description>
              <link>https://borinorge.no/projects/nettverk</link>
              <pubDate>Sun, 01 Dec 2024 11:00:00 GMT</pubDate>
            </item>
            
            <item>
              <title>Lær norsk lett</title>
              <description>
                Lær norsk lett tilbyr de beste språklæringsressursene, inkludert lesing, lytting, skriving og muntlig praksis for nivåene A1, A2, B1, og B2. 
                Totalt 14 ressurser er tilgjengelige, inkludert LearnNoW, Norskappen, og Klar Tale.
              </description>
              <link>https://borinorge.no/norsklett</link>
              <pubDate>Sun, 02 Nov 2024 10:00:00 GMT</pubDate>
            </item>
            
            <item>
              <title>Ordbøkene</title>
              <description>
                Bokmålsordboka og Nynorskordboka er standardordbøkene i Norge, tilgjengelige som nettsider og apper. 
                I 2024 ble en ukrainsk oversettelse av brukergrensesnittet lansert, et innovativt prosjekt utført av et dedikert team med støtte fra Universitetet i Bergen og Språkrådet.
              </description>
              <link>https://borinorge.no/projects/ordbokene</link>
              <pubDate>Sun, 03 Oct 2024 12:00:00 GMT</pubDate>
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
    return Consumer<ItemsController>(
      builder: (context, itemsController, child) {
        final localizedItems = itemsController.items(context);

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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.latestNews,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                FutureBuilder<RssFeed>(
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
                            subtitle: Text(item.pubDate?.toLocal().toString() ?? ''),
                            onTap: () async {
                              if (item.link != null) {
                                final url = Uri.parse(item.link!);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(AppLocalizations.of(context)!.cannotLaunchUrl)),
                                  );
                                }
                              }
                            },
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    itemCount: localizedItems.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final item = localizedItems[index];
                      return ListTile(
                        title: Text(
                          item.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        leading: CircleAvatar(
                          foregroundImage: AssetImage(item.logo),
                        ),
                        onTap: () {
                          if (item.id == 3) {
                            context.push("/about");
                          } else {
                            context.push("/chat", extra: item);
                          }
                        },
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
