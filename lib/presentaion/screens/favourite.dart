import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/presentaion/widgets/recipeItemWidget.dart';

import '../../providers/recipe_provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    var rp = Provider.of<RecipeProvider>(context);
    var recipes = rp.recipes;
    var isLoading = rp.isLoading;
    var errorMsg = rp.errorMsg;
    if (errorMsg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMsg'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : Column(
              children: [
                Text("All Recipes"),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Recipeitemwidget(recipe: recipes[index]);
                  },
                  itemCount: recipes.length,
                ),
              ],
            ),
    );
  }
}
