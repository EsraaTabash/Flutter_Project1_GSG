import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';
import 'package:recipe_book_application/data/repo/recipeRepo.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipemodel> recipes = [];

  bool isLoading = false;
  String errorMsg = '';

  Future<void> fetchRecipes() async {
    try {
      isLoading = true;
      errorMsg = '';
      notifyListeners();

      final data = await Reciperepo.fetchRecipes();
      recipes = data;
    } catch (e) {
      errorMsg = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
