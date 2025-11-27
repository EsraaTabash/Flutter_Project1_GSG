import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {
  static late SharedPreferences prefs;

  static const String userNameKey = "userNameKey";
  static const String userEmailKey = "userEmailKey";
  static const String favoritesKey = "favoriteRecipes";
  static const String userPhoneKey = "userPhoneKey";

  static Future<void> initService() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> login({
    required String name,
    required String email,
    String? phone,
  }) async {
    await prefs.setString(userNameKey, name);
    await prefs.setString(userEmailKey, email);
    if (phone != null) {
      await prefs.setString(userPhoneKey, phone);
    }
  }

  static Future<void> signup({
    required String name,
    required String email,
    required String phone,
  }) async {
    await prefs.setString(userNameKey, name);
    await prefs.setString(userEmailKey, email);
    await prefs.setString(userPhoneKey, phone);
  }

  static Future<void> logout() async {
    await prefs.remove(userNameKey);
    await prefs.remove(userEmailKey);
    await prefs.remove(userPhoneKey);
    await prefs.remove(favoritesKey);
  }

  static String? getUserName() {
    return prefs.getString(userNameKey);
  }

  static String? getUserEmail() {
    return prefs.getString(userEmailKey);
  }

  static String? getUserPhone() {
    return prefs.getString(userPhoneKey);
  }

  static List<String> getFavorites() {
    return prefs.getStringList(favoritesKey) ?? [];
  }

  static Future<void> toggleFavorite(int recipeId) async {
    final current = getFavorites();
    if (current.contains(recipeId.toString())) {
      current.remove(recipeId.toString());
    } else {
      current.add(recipeId.toString());
    }
    await prefs.setStringList(favoritesKey, current);
  }

  static bool isFavorite(int recipeId) {
    final current = getFavorites();
    return current.contains(recipeId.toString());
  }
}
