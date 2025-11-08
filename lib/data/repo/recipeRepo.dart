import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:recipe_book_application/data/models/recipeModel.dart';

class Reciperepo {
  static Future<List<Recipemodel>> fetchRecipes() async {
    var response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?number=20&addRecipeInformation=true&apiKey=bdc570e7c10b4ec7b7fdd70ab9c8ff99',
      ),
    );
    log(response.body);
    var data = jsonDecode(response.body);
    List<dynamic> recipesJson = data['results'];
    List<Recipemodel> recipes = [];
    for (var recipeJson in recipesJson) {
      recipes.add(Recipemodel.fromJson(recipeJson));
    }
    return recipes;
  }
}
