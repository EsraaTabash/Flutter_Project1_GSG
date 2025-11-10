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
    var recipes = rp.recipes ?? const [];
    var isLoading = rp.isLoading;
    var errorMsg = rp.errorMsg;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : (errorMsg != null && errorMsg.isNotEmpty)
          ? Center(child: Text((errorMsg)))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "All Recipes",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Recipeitemwidget(recipe: recipes[index]),
                      );
                    },
                    itemCount: recipes.length,
                  ),
                ),
              ],
            ),
    );
  }
}
