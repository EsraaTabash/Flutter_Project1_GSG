import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/presentaion/widgets/recipeCardWidget.dart';
import 'package:recipe_book_application/presentaion/widgets/recipeItemWidget.dart';
import '../../providers/recipe_provider.dart';

class Allrecipes extends StatefulWidget {
  const Allrecipes({super.key});

  @override
  State<Allrecipes> createState() => _AllrecipesState();
}

class _AllrecipesState extends State<Allrecipes> {
  Widget build(BuildContext context) {
    var rp = Provider.of<RecipeProvider>(context);
    var recipes = rp.recipes;
    var isLoading = rp.isLoading;
    var errorMsg = rp.errorMsg;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : Column(
              children: [
                Text("All Recipes", style: TextStyle(fontSize: 20)),
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Recipecardwidget(recipe: recipes[index]);
                    },
                    itemCount: recipes.length,
                  ),
                ),
              ],
            ),
    );
  }
}
