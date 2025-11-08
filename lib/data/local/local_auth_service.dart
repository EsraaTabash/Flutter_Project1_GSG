import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthService {
  static late SharedPreferences prefs;

  static const String userKey = "userNameKey";
  static const String favoritesKey = "favoriteRecipes";

  static Future<void> initService() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> login(String name) async {
    await prefs.setString(userKey, name);
  }

  static Future<void> signup(String name) async {
    await prefs.setString(userKey, name);
  }

  static Future<void> logout() async {
    await prefs.remove(userKey);
  }

  static String? getUserName() {
    return prefs.getString(userKey);
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

  static Future<void> clearFavorites() async {
    await prefs.remove(favoritesKey);
  }
}
