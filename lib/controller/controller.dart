import 'dart:async';
import 'package:d3_season_journey/model/challenge_model.dart';
import 'package:d3_season_journey/model/season_journey_model.dart';
import 'package:d3_season_journey/model/stats_model.dart';
import 'package:d3_season_journey/repository/db_provider.dart';
import 'package:d3_season_journey/service/api_service.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  static Controller get to => Get.find();
  bool initialised = false;
  late SeasonJourneyModel seasonJourneyModel;
  final DBProvider _dbProvider = DBProvider();
  Stats stats = Stats();
  final ApiService _httpService = Get.find();

  Controller() {
    _init();
  }

  Controller.empty();

  Future<void> _init() async {
    seasonJourneyModel = await _httpService.getSchema();
    bool firstTimeInit = await _dbProvider.initDb(seasonJourneyModel.title);
    if (firstTimeInit) {
      await _dbProvider.insertAllChallenges(seasonJourneyModel);
    }
    for (Chapter chapter in seasonJourneyModel.chapters) {
      chapter.challengeModels = await _dbProvider.getChallengesFromChapter(chapter.title);
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
    await _dbProvider.toggleCompleted(updatedChallenge);
    await _setCheckedValues();
    update();
  }

  Future<void> clearCompletedChallenges() async {
    await _dbProvider.clearCompletedChallenges();
    await _dbProvider.insertAllChallenges(seasonJourneyModel);
    for (Chapter chapter in seasonJourneyModel.chapters) {
      for (Challenge challenge in chapter.challengeModels) {
        challenge.isCompleted = false;
      }
    }
    await _setCheckedValues();
    update();
  }

  Future<void> _setCheckedValues() async => stats.setCheckedValues(await _dbProvider.getAllChecked(), maxChallengesAmount());

  int maxChallengesAmount() => seasonJourneyModel.chapters.fold(0, (previousValue, element) => previousValue + element.challenges.length);

  Chapter getChapterWithIndex(int index) => seasonJourneyModel.chapters[index];
}
