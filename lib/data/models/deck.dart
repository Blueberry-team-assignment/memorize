class Deck {
  int? id;
  String title;
  String desc;

  Deck({
    this.id,
    required this.title,
    required this.desc,
  });

  Map<String, Object?> toMap() {
    var map = <String, Object?>{"title": title, "desc": desc};
    map["id"] = id;
    return map;
  }

  Deck.fromMap(Map<String, Object?> map)
      : id = map["id"] as int,
        title = map["title"] as String,
        desc = map["desc"] as String;
}
