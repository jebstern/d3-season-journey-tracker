import 'dart:io';
import 'package:d3_season_journey/model/challenge_model.dart';
import 'package:d3_season_journey/model/season_journey_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableChallenges = 'challenges';
const String columnTitle = 'title';
const String columnChapter = 'chapter';
const String columnIsCompleted = 'isCompleted';
const String createChallengeSql = "CREATE TABLE $tableChallenges ("
    "id INTEGER AUTO_INCREMENT PRIMARY KEY,"
    "$columnTitle TEXT,"
    "$columnChapter TEXT,"
    "$columnIsCompleted INTEGER DEFAULT 0)";

class DBProvider {
  late final Database _db;

  Future<bool> initDb(String seasonTitle) async {
    bool firstTimeInit = false;
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, seasonTitle);
    _db = await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(createChallengeSql);
      firstTimeInit = true;
    });
    return firstTimeInit;
  }

  Future<void> insertAllChallenges(SeasonJourneyModel seasonJourneyModel) async {
    for (Chapter chapter in seasonJourneyModel.chapters) {
      for (String challenge in chapter.challenges) {
        await _db.rawUpdate("INSERT INTO $tableChallenges($columnTitle, $columnChapter, $columnIsCompleted) VALUES (?, ?, ?)", [challenge, chapter.title, 0]);
      }
    }
  }

  Future<int> getAllChecked() async {
    List<Map<String, dynamic>> result = await _db.rawQuery('SELECT COUNT(*) as checked FROM $tableChallenges WHERE $columnIsCompleted=1');
    Map<String, dynamic> row = result.first;
    return row['checked'];
  }

  Future<bool> toggleCompleted(Challenge challenge) async {
    int isUpdated = 0;
    isUpdated = await _db
        .rawUpdate('UPDATE $tableChallenges SET $columnIsCompleted = ? WHERE $columnTitle = ? AND $columnChapter = ?', [challenge.isCompleted == true ? 1 : 0, challenge.title, challenge.chapter]);
    return isUpdated == 1;
  }

  Future<void> clearCompletedChallenges() async {
    await _db.rawQuery("DELETE FROM $tableChallenges");
  }

  Future<List<Challenge>> getChallengesFromChapter(String chapter) async {
    final List<Map<String, dynamic>> maps = await _db.query(tableChallenges, where: '$columnChapter = ?', whereArgs: [chapter]);
    return List.generate(maps.length, (i) {
      return Challenge(
        chapter: maps[i]['chapter'],
        title: maps[i]['title'],
        isCompleted: maps[i]['isCompleted'] == 1,
      );
    });
  }
}
