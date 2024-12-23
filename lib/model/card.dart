class Card {
  int? id;
  String title;
  String desc;
  int deckId;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "title": title,
      "desc": desc,
      "deck_id": deckId
    };
    map["id"] = id;
    return map;
  }

  Card({
    this.id,
    required this.title,
    required this.desc,
    required this.deckId,
  });

  Card.fromMap(Map<String, Object?> map)
      : id = map["id"] as int,
        title = map["title"] as String,
        desc = map["desc"] as String,
        deckId = map["deck_id"] as int;
}
