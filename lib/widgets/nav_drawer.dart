import 'package:d3_season_journey/controller/controller.dart';
import 'package:d3_season_journey/pages/chapter_page.dart';
import 'package:d3_season_journey/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawerWidget extends StatelessWidget {
  const NavDrawerWidget({Key? key}) : super(key: key);
  final String _privacyPolicy = "http://www.privacy-policy.jebstern.com/";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      builder: (controller) => Drawer(
        child: Builder(
          builder: (context) => Container(
            color: const Color(0xff2f1111),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const ScrollPhysics(parent: PageScrollPhysics()),
              children: [
                const UserAccountsDrawerHeader(
                  accountName: Text("D3 Season Journey tracker"),
                  accountEmail: Text(""),
                ),
                ..._getDrawerItems(controller),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.white),
                  title: const Text("Share progress"),
                  onTap: () {
                    Get.back();
                    Share.share("My current D3 - ${controller.seasonJourneyModel.title} progress: ${controller.stats.progress} challenges.");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.white),
                  title: const Text("Privacy policy"),
                  onTap: () {
                    Get.back();
                    _launchURL();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white),
                  title: const Text("Settings"),
                  onTap: () {
                    Get.back();
                    Get.to(() => SettingsPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getDrawerItems(Controller controller) {
    List<Widget> items = [];

    if (controller.seasonJourneyModel.chapters.isEmpty) {
      return items;
    }

    for (int i = 0; i < controller.seasonJourneyModel.chapters.length; i++) {
      items.add(ListTile(
        leading: const Icon(Icons.flare_sharp, color: Colors.white),
        title: Text(controller.seasonJourneyModel.chapters[i].title),
        onTap: () {
          Get.back();
          Get.to(() => ChapterPage(chapter: controller.seasonJourneyModel.chapters[i]));
        },
        trailing: Text(_completionText(controller, i)),
      ));
    }

    return items;
  }

  void _launchURL() async => await canLaunch(_privacyPolicy) ? await launch(_privacyPolicy) : throw 'Could not launch $_privacyPolicy';

  String _completionText(Controller controller, int index) {
    int done = controller.seasonJourneyModel.chapters[index].challengeModels.fold(0, (previousValue, element) => previousValue + (element.isCompleted ? 1 : 0));
    int total = controller.seasonJourneyModel.chapters[index].challenges.length;
    return "$done/$total";
  }
}
