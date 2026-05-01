import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for interacting with the device's shared preferences.
class SharedPrefHelper {
  static late SharedPreferences _prefs;

  /// Initializes the [SharedPreferences] instance.
  /// 
  /// This should be called before any other methods.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Stores a [String] value associated with the given [key].
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// Retrieves a [String] value associated with the given [key].
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Stores a [bool] value associated with the given [key].
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Retrieves a [bool] value associated with the given [key].
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Stores an [int] value associated with the given [key].
  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Retrieves an [int] value associated with the given [key].
  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Removes the value associated with the given [key].
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Clears all stored values from shared preferences.
  /// 
  /// TODO: Add a confirmation or warning before clearing all data.
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
