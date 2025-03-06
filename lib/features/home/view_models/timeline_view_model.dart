import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/post/repos/mood_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineViewModel extends StreamNotifier<List<MoodModel>> {
  late final MoodRepository _repository;
  @override
  Stream<List<MoodModel>> build() {
    _repository = ref.read(moodRepo);

    return getMood();
  }

  Stream<List<MoodModel>> getMood() {
    return _repository.fetchMood();
  }
}

final timelineProvider =
    StreamNotifierProvider<TimelineViewModel, List<MoodModel>>(
      () => TimelineViewModel(),
    );
