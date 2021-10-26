import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:d3_season_journey/model/challenge_model.dart';
import 'package:d3_season_journey/model/season_journey_model.dart';
import 'package:d3_season_journey/model/stats_model.dart';
import 'package:d3_season_journey/repository/db_provider.dart';
import 'package:d3_season_journey/service/api_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();
  bool initialised = false;
  late SeasonJourneyModel seasonJourneyModel;
  DBProvider dbProvider = DBProvider();
  Stats stats = Stats();
  final ApiService _httpService = Get.find();


  Controller() {
    _init();
  }

  Controller.empty();

  Future<void> _init() async {
    String jsonString = await rootBundle.loadString("assets/seasonJourney.json");
    seasonJourneyModel = SeasonJourneyModel.fromJson(json.decode(jsonString));
    seasonJourneyModel = await _httpService.getSchema();
    bool firstTimeInit = await dbProvider.initDb(seasonJourneyModel.title);
    if (firstTimeInit) {
      await dbProvider.insertAllChallenges(seasonJourneyModel);
    }
    for (Chapter chapter in seasonJourneyModel.chapters) {
      chapter.challengeModels = await dbProvider.getChallengesFromChapter(chapter.title);
    }
    await _setCheckedValues();
    initialised = true;
    update();
  }

  Future<void> toggleCompleted(Chapter chapter, Challenge updatedChallenge) async {
    seasonJourneyModel.chapters
        .firstWhere((listChapter) => listChapter.title == chapter.title)
        .challengeModels
        .firstWhere((listChallenge) => listChallenge.title == updatedChallenge.title)
        .isCompleted = !updatedChallenge.isCompleted;
    await dbProvider.toggleCompleted(updatedChallenge);
    await _setCheckedValues();
    update();
  }

  Future<void> clearCompletedChallenges() async {
    await dbProvider.clearCompletedChallenges();
    await _setCheckedValues();
  }

  Future<void> _setCheckedValues() async => stats.setCheckedValues(await dbProvider.getAllChecked(), maxChallengesAmount());

  int maxChallengesAmount() => seasonJourneyModel.chapters.fold(0, (previousValue, element) => previousValue + element.challenges.length);

  Chapter getChapterWithIndex(int index) => seasonJourneyModel.chapters[index];
}
