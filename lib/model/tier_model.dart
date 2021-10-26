class Tier {
  late int id;
  late String title;
  late String reward;

  Tier({
    required this.title,
    required this.reward,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'reward': reward,
    };
    return map;
  }

  Tier.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    reward = map['reward'];
  }
}
