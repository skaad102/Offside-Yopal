

abstract class PreferencesRepository{
  bool get isDarkmode;
  Future<void> darkMode(bool enabled);
}