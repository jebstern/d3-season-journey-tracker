class Challenge {
  int? id;
  late String title;
  late String chapter;
  late bool isCompleted;

  Challenge({
    required this.title,
    required this.chapter,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'tier': chapter,
    };
    return map;
  }

  Challenge.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    chapter = map['tier'];
    isCompleted = map['isCompleted'] == 1;
  }
}
