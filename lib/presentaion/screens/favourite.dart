import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
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
    final rp = Provider.of<RecipeProvider>(context);
    final recipes = rp.recipes ?? const [];
    final isLoading = rp.isLoading;
    final errorMsg = rp.errorMsg;

    final fav = LocalAuthService.getFavorites();

    final favRecipes = recipes.where((r) {
      final id = (r.recipeId ?? 0).toString();
      return fav.contains(id);
    }).toList();

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : (errorMsg.isNotEmpty)
          ? Center(child: Text(errorMsg))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Favourite Recipes",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),

                if (favRecipes.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "No Favourite Recipes",
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Inter',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: favRecipes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Recipeitemwidget(recipe: favRecipes[index]),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}
