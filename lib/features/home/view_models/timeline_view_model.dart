import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/post/repos/mood_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, bool> {
  late final MoodRepository _repository;
  @override
  Stream<List<MoodModel>> build(bool isOnlyMine) {
    _repository = ref.read(moodRepo);

    return getMood(isOnlyMine);
  }

  Stream<List<MoodModel>> getMood(bool isOnlyMine) {
    final uid = ref.read(authRepo).user!.uid;
    print("TimelineViewModel : getMood : uid = $uid");
    return _repository.fetchMood(isOnlyMine, uid);
  }
}

final timelineProvider = AutoDisposeStreamNotifierProvider.family<
  TimelineViewModel,
  List<MoodModel>,
  bool
>(() => TimelineViewModel());
