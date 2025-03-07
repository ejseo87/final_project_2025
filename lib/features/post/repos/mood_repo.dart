import "package:cloud_firestore/cloud_firestore.dart";
import "package:final_project_2025/features/post/models/mood_model.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> saveMood(MoodModel moodData) async {
    final newMoodRef = _db.collection("moods").doc();
    print("MoodRepository : saveMood : newMoodRef.id = ${newMoodRef.id}");
    moodData = moodData.copyWith(moodId: newMoodRef.id);
    await newMoodRef.set(moodData.toJson());
    return newMoodRef.id;
  }

  Future<void> deleteMood(MoodModel moodData) async {
    print("MoodRepository : deleteMood : moodData.moodId = ${moodData.moodId}");
    await _db.collection("moods").doc(moodData.moodId).delete();
  }

  Stream<List<MoodModel>> fetchMood(bool isOnlyMine, String uid) {
    print("MoodRepository : fetchMood");
    final CollectionReference<Map<String, dynamic>> query;
    if (isOnlyMine) {
      query = _db.collection("users").doc(uid).collection("moods");
    } else {
      query = _db.collection("moods");
    }
    final result = query.orderBy("createAt", descending: true).snapshots();
    final result2 = result.map(
      (event) =>
          event.docs.map((doc) => MoodModel.fromJson(doc.data())).toList(),
    );
    return result2;
  }
}

final moodRepo = Provider((ref) => MoodRepository());
