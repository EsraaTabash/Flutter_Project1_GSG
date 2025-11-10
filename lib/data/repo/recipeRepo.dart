import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_book_application/data/models/recipeModel.dart';

class Reciperepo {
  static const _base = 'https://api.spoonacular.com/recipes/complexSearch';
  static const _apiKey = 'bdc570e7c10b4ec7b7fdd70ab9c8ff99';

  static Future<List<Recipemodel>> fetchRecipes({
    int number = 20,
    String? sort, // popularity, healthiness
  }) async {
    final uri = Uri.parse(_base).replace(
      queryParameters: {
        'number': '$number',
        'addRecipeInformation': 'true',
        if (sort != null) 'sort': sort,
        'apiKey': _apiKey,
      },
    );

    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('API error ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final results = (data['results'] as List? ?? []);
    List<Recipemodel> recipes = [];
    for (var recipeJson in results) {
      recipes.add(Recipemodel.fromJson(recipeJson));
    }
    return recipes;
  }

  static Future<List<Recipemodel>> fetchTopPopular() {
    return fetchRecipes(number: 5, sort: 'popularity');
  }

  static Future<List<Recipemodel>> fetchTopHealthy() {
    return fetchRecipes(number: 5, sort: 'healthiness');
  }
}
