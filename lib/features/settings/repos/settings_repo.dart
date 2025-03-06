import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String _darkmode = "darkmode";

  final SharedPreferences _preferences;
  SettingsRepository(this._preferences);

  Future<void> setDarkmode(bool value) async {
    _preferences.setBool(_darkmode, value);
  }

  bool isDarkmode() {
    return _preferences.getBool(_darkmode) ?? false;
  }
}
