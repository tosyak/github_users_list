import 'package:shared_preferences/shared_preferences.dart';

import 'package:github_test_app/utils/logger.dart';

// This enum defines constants used as keys for SharedPreferences
enum SharedPrefsKeys {
  firstStart, // Key for isFirstStart preference
  isDark, // Key for isDark preference
  isRu, // Key for isRu preference (assuming Ru refers to Russian language)
}

class SharedPreferencesManager {
  // Private constructor to prevent direct instantiation (Singleton pattern)
  SharedPreferencesManager._internal();

  // The single instance of this class
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  // Public accessor for the instance
  static SharedPreferencesManager get instance => _instance;

  // SharedPreferences object will be initialized later
  late SharedPreferences _prefs;

  // Asynchronous method to initialize SharedPreferences
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (error, stackTrace) {
      // Handle initialization error (e.g., log the error)
      logger.e("Error initializing SharedPreferences: $error");
      throw Exception(
          'Error initializing SharedPreferences: $error, stackTrace $stackTrace');
    }
  }

  // Save data using unique keys (adapt for different data types)
  Future<void> setString(SharedPrefsKeys key, String value) async {
    await _prefs.setString(key.toString(), value);
  }

  Future<void> setBool(SharedPrefsKeys key, bool value) async {
    await _prefs.setBool(key.toString(), value);
  }

  // Get data using the same key
  Future<String?> getString(SharedPrefsKeys key) async {
    try {
      return _prefs.getString(key.toString());
    } catch (error) {
      // Handle missing key or other errors (e.g., return default value)
      logger.e("Error getting string for key $key: $error");

      return null;
    }
  }

  Future<bool?> getBool(SharedPrefsKeys key) async {
    try {
      return _prefs.getBool(key.toString());
    } catch (error) {
      // Handle missing key or other errors (e.g., return default value)
      logger.e("Error getting bool for key $key: $error");

      return null;
    }
  }

  // Remove data
  Future<void> remove(SharedPrefsKeys key) async {
    await _prefs.remove(key.toString());
  }

  // Clear all data (use with caution)
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
