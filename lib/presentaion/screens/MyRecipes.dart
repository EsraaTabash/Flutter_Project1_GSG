import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/local/recipesSqlite.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';
import 'package:recipe_book_application/presentaion/widgets/MyRecipeListItem.dart';
import 'package:recipe_book_application/presentaion/widgets/RecipeFormSheet.dart';

class Myrecipes extends StatefulWidget {
  @override
  State<Myrecipes> createState() => _MyrecipesState();
}

class _MyrecipesState extends State<Myrecipes> {
  List<Recipemodel> myRecipes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "My Recipes",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00B4BF),
        foregroundColor: Colors.white,
        onPressed: () => openForm(),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
              "Your personal saved recipes — only visible to you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFF00B4BF)),
                  )
                : myRecipes.isEmpty
                ? Center(
                    child: Text(
                      "You don’t have any recipes yet.\nTap + to add your first one!",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: myRecipes.length,
                    itemBuilder: (_, i) => MyRecipeListItem(
                      recipe: myRecipes[i],
                      onEdit: () => openForm(recipe: myRecipes[i]),
                      onDelete: () => deleteRecipe(myRecipes[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> loadRecipes() async {
    setState(() => isLoading = true);

    myRecipes = await Recipessqlite.getRecipesFromDb();

    setState(() => isLoading = false);
  }

  Future<void> openForm({Recipemodel? recipe}) async {
    final result = await showModalBottomSheet<Recipemodel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecipeFormSheet(recipe: recipe),
    );

    if (result != null) {
      recipe == null
          ? await Recipessqlite.insertRecipeToDb(result)
          : await Recipessqlite.updateRecipeToDb(result);
      loadRecipes();
    }
  }

  Future<void> deleteRecipe(Recipemodel r) async {
    await Recipessqlite.deleteRecipeFromDb(r);
    loadRecipes();
  }
}
