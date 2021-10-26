import 'package:d3_season_journey/model/challenge_model.dart';

class SeasonJourneyModel {
  String title;
  List<Chapter> chapters;

  SeasonJourneyModel({this.title = "Unknown season", this.chapters = const []});

  factory SeasonJourneyModel.fromJson(Map<String, dynamic> json) {
    return SeasonJourneyModel(
      title: json["title"] ?? "",
      chapters: List<Chapter>.from(
        json["chapters"].map((x) => Chapter.fromJson(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "chapters": List<dynamic>.from(
          chapters.map((x) => x.toJson()),
        ),
      };
}

class Chapter {
  Chapter({
    this.title = "",
    this.challenges = const [],
    this.challengeModels = const [],
    this.reward = "",
  });

  String title;
  List<String> challenges;
  List<Challenge> challengeModels;
  String reward;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        title: json["title"] ?? "",
        challenges: List<String>.from(
          json["challenges"].map((x) => x) ?? [],
        ),
        reward: json["reward"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "challenges": List<dynamic>.from(
          challenges.map((x) => x),
        ),
        "reward": reward,
      };
}
