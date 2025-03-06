class MoodModel {
  final String moodId;
  final String creatorUid;
  final String mood;
  final String emoticon;
  final int createAt;

  MoodModel({
    required this.moodId,
    required this.creatorUid,
    required this.mood,
    required this.emoticon,
    required this.createAt,
  });

  MoodModel.fromJson(Map<String, dynamic> json)
    : moodId = json["moodId"],
      creatorUid = json["creatorUid"],
      mood = json["mood"],
      emoticon = json["emoticon"],
      createAt = json["createAt"];

  Map<String, dynamic> toJson() {
    return {
      "moodId": moodId,
      "creatorUid": creatorUid,
      "mood": mood,
      "emoticon": emoticon,
      "createAt": createAt,
    };
  }

  MoodModel copyWith({
    String? moodId,
    String? creatorUid,
    String? mood,
    String? emoticon,
    int? createAt,
  }) {
    return MoodModel(
      moodId: moodId ?? this.moodId,
      creatorUid: creatorUid ?? this.creatorUid,
      mood: mood ?? this.mood,
      emoticon: emoticon ?? this.emoticon,
      createAt: createAt ?? this.createAt,
    );
  }
}
