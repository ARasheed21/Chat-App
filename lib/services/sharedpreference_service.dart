import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _usernameKey = 'username';
  static const String _photoUrlKey = 'photoUrl';

  // Save the username to SharedPreferences
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // Retrieve the username from SharedPreferences
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // Delete the username from SharedPreferences
  static Future<void> deleteUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
  }

  // Save the photo url to SharedPreferences
  static Future<void> savePhotoUrl(String photoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_photoUrlKey, photoUrl);
  }

  // Retrieve the photo url from SharedPreferences
  static Future<String?> getPhotoUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_photoUrlKey);
  }

  // Delete the username from SharedPreferences
  static Future<void> deletePhotoUrl() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_photoUrlKey);
  }
}
