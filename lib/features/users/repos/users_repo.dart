import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/users/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> saveUsersMood(MoodModel moodData) async {
    final newMoodRef = _db
        .collection("users")
        .doc(moodData.creatorUid)
        .collection("moods")
        .doc(moodData.moodId);
    await newMoodRef.set(moodData.toJson());
  }

  Future<void> deleteUsersMood(MoodModel moodData) async {
    print(
      "UsersRepository : deleteUsersMood : moodData.creatorUid =${moodData.creatorUid} moodData.moodId = ${moodData.moodId}",
    );
    _db
        .collection("users")
        .doc(moodData.creatorUid)
        .collection("moods")
        .doc(moodData.moodId)
        .delete()
        .then(
          (doc) => print("Documnet deleted"),
          onError: (e) => print("Error deleting document $e "),
        );
  }
}

final usersRepo = Provider((ref) => UsersRepository());
