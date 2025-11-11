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
  final ScrollController _autoController = ScrollController();

  @override
  void initState() {
    super.initState();
    //fetchRecipes();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  @override
  Widget build(BuildContext context) {
    var rv = Provider.of<RecipeProvider>(context);
    var recipes = rv.recipes ?? [];
    var isLoading = rv.isLoading;
    var errorMsg = rv.errorMsg;
    final popularSorted = [
      ...recipes,
    ]..sort((a, b) => (b.aggregateLikes ?? 0).compareTo(a.aggregateLikes ?? 0));
    final topPopular = popularSorted.take(5).toList();
    final healthySorted = [...recipes]
      ..sort(
        (a, b) =>
            ((b.recipeHealthScore ?? 0).compareTo(a.recipeHealthScore ?? 0)),
      );
    final topHealthy = healthySorted.take(5).toList();

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://culinaryclassroom.com/wp-content/uploads/2024/02/How-To-Become-a-Better-Cook-1024x585-1024x585.jpg',
                        ),
                        fit: BoxFit.cover,
                        opacity: .5,
                        colorFilter: ColorFilter.mode(
                          Colors.white60,
                          BlendMode.lighten,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30,
                            left: 50,
                            right: 50,
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
                          padding: EdgeInsets.only(
                            left: 50,
                            right: 50,
                            top: 30,
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
                          padding: EdgeInsets.only(left: 50, right: 50),
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
                                  color: const Color.fromARGB(
                                    255,
                                    201,
                                    238,
                                    240,
                                  ),
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
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 226, 244, 144),
                          Color.fromARGB(255, 245, 235, 163),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Most Popular Recipes",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: ListView.separated(
                      controller: _autoController,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: topPopular.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 200,
                          child: Recipecardwidget(recipe: topPopular[index]),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 226, 244, 144),
                          Color.fromARGB(255, 245, 235, 163),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Most Healthy Recipes",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: topHealthy.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 200,
                          child: Recipecardwidget(recipe: topHealthy[index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 226, 244, 144),
                          Color.fromARGB(255, 245, 235, 163),
                        ],
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "All Recipes",
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
                      top: 24,
                      left: 20,
                      right: 20,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: (context, index) {
                        return Recipecardwidget(recipe: recipes[index]);
                      },
                      itemCount: recipes.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      final max = _autoController.position.maxScrollExtent;
      final next = _autoController.offset >= max
          ? 0.0
          : (_autoController.offset + 220).toDouble();

      _autoController.animateTo(
        next,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _autoController.dispose();
    super.dispose();
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
