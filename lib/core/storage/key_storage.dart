/// A central repository for all keys used for persistent storage (e.g., SharedPreferences).
class KeyStorage {
  /// Key for storing the user's authentication token.
  static const String token = 'auth_token';
  
  /// Key for tracking if it's the user's first time opening the app.
  static const String isFirstTime = 'is_first_time';
  
  /// Key for storing the logged-in user's unique identifier.
  static const String userId = 'user_id';
  
  /// Key for storing the preferred language code.
  static const String languageCode = 'language_code';
  
  /// Key for storing the preferred country code.
  static const String countryCode = 'country_code';
  
  /// Key for storing the user's theme preference (dark mode enabled/disabled).
  static const String isDarkMode = 'is_dark_mode';

  /// Key for storing the logged-in user's email.
  static const String userEmail = 'user_email';
}
