import 'package:flutter/material.dart';
import 'package:recipe_book_application/presentaion/widgets/recipeCardWidget.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/providers/recipe_provider.dart';
import '../../data/repo/recipeRepo.dart';

class Home extends StatefulWidget {
  final String name;

  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //bool isLoading = true;
  //String errorMsg = '';
  //List<Recipemodel> recipes = [];
  @override
  void initState() {
    super.initState();
    //fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    var rv = Provider.of<RecipeProvider>(context);
    var recipes = rv.recipes;
    var isLoading = rv.isLoading;
    var errorMsg = rv.errorMsg;

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://culinaryclassroom.com/wp-content/uploads/2024/02/How-To-Become-a-Better-Cook-1024x585-1024x585.jpg',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 20,
                    bottom: 10,
                    right: 20,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hello ${widget.name} 👋 What is in your kitchen?",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter some ingredients to search",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff424242),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      hintText: 'Type your ingredients',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: Color(0xffAEAEAE),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 201, 238, 240),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0XFF00B4BF),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 245,
                      ),
                      itemBuilder: (context, index) {
                        return Recipecardwidget(recipe: recipes[index]);
                      },
                      itemCount: recipes.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Future<void> fetchRecipes() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //       errorMsg = '';
  //     });
  //     final data = await Reciperepo.fetchRecipes();
  //     setState(() {
  //       isLoading = false;
  //       recipes = data;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       errorMsg = e.toString();
  //       isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $errorMsg'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }
}
