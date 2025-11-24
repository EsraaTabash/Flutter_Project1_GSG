import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/data/local/recipesSqlite.dart';
import 'package:recipe_book_application/presentaion/screens/login.dart';

import 'providers/recipe_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalAuthService.initService();
  await Recipessqlite.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => RecipeProvider()..fetchRecipes(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Login()),
    ),
  );
}
