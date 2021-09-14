


import 'package:offside_yopal/app/domain/repositories/preferences_respository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const darkModeKey = 'Modo-Oscuro';

class PreferencesRepositoryImpl implements PreferencesRepository{
  final SharedPreferences _preferences  ;

  PreferencesRepositoryImpl(this._preferences);
  @override

  bool get isDarkmode => _preferences.getBool(darkModeKey)??false;

  @override
  Future<void> darkMode(bool enabled) {
   return _preferences.setBool(darkModeKey, enabled);
  }
  
}