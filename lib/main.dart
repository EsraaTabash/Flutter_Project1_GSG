import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/cubit/auth_cubit.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/data/local/recipesSqlite.dart';
import 'package:recipe_book_application/firebase_options.dart';
import 'package:recipe_book_application/presentaion/screens/splash.dart';
import 'providers/recipe_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalAuthService.initService();
  await Recipessqlite.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    BlocProvider(
      create: (_) => AuthCubit()..checkIfLoggedIn(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RecipeProvider()..fetchRecipes(),
          ),
        ],
        child: MaterialApp(debugShowCheckedModeBanner: false, home: Splash()),
      ),
    ),
  );
}
