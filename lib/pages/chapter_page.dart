import 'package:d3_season_journey/controller/controller.dart';
import 'package:d3_season_journey/model/challenge_model.dart';
import 'package:d3_season_journey/model/season_journey_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterPage extends StatelessWidget {
  final Chapter chapter;
  const ChapterPage({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(chapter.title),
        ),
        body: GetBuilder<Controller>(
          builder: (controller) => TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: _challengesWidget(controller),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  chapter.reward,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(child: Text("Challenges", style: TextStyle(fontSize: 22))),
            Tab(child: Text("Rewards", style: TextStyle(fontSize: 22))),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.redAccent,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }

  List<Widget> _challengesWidget(Controller controller) {
    return chapter.challengeModels.map((Challenge challenge) {
      return CheckboxListTile(
        title: Text(challenge.title),
        value: challenge.isCompleted,
        onChanged: (value) => controller.toggleCompleted(chapter, challenge),
      );
    }).toList();
  }
}
