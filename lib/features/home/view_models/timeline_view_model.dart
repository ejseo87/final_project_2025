import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/post/repos/mood_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel
    extends AutoDisposeFamilyStreamNotifier<List<MoodModel>, String> {
  late final MoodRepository _repository;
  @override
  Stream<List<MoodModel>> build(String viewmode) {
    _repository = ref.read(moodRepo);

    return getMood(viewmode);
  }

  Stream<List<MoodModel>> getMood(String viewmode) {
    final uid = ref.read(authRepo).user!.uid;
    print("TimelineViewModel : getMood : uid = $uid");
    return _repository.fetchMood(viewmode, uid);
  }
}

final timelineProvider = AutoDisposeStreamNotifierProvider.family<
  TimelineViewModel,
  List<MoodModel>,
  String
>(() => TimelineViewModel());
