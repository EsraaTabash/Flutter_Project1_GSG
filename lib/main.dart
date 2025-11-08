import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/presentaion/screens/mainNav.dart';

import 'providers/recipe_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalAuthService.initService();
  runApp(
    ChangeNotifierProvider(
      create: (_) => RecipeProvider()..fetchRecipes(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Mainnav()),
    ),
  );
}
