import 'package:final_project_2025/features/settings/models/settings_model.dart';
import 'package:final_project_2025/features/settings/repos/settings_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsViewModel extends Notifier<SettingsModel> {
  final SettingsRepository _repository;
  SettingsViewModel(this._repository);

  void setDarkmode(bool value) {
    _repository.setDarkmode(value);
    state = SettingsModel(darkmode: value);
  }

  @override
  SettingsModel build() {
    return SettingsModel(darkmode: _repository.isDarkmode());
  }
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingsModel>(
  () => throw UnimplementedError(),
);
