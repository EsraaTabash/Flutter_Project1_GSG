import 'package:flutter/material.dart';
import 'package:recipe_book_application/presentaion/screens/allRecipes.dart';
import 'package:recipe_book_application/presentaion/screens/favourite.dart';
import 'package:recipe_book_application/presentaion/screens/home.dart';

class Mainnav extends StatefulWidget {
  String? name;
  Mainnav({this.name, super.key});

  @override
  State<Mainnav> createState() => _MainnavState();
}

class _MainnavState extends State<Mainnav> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      Home(name: widget.name ?? "Guest"),
      Allrecipes(),
      Favourite(),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: const Color.fromARGB(255, 201, 238, 240),
        title: Image.asset("assets/logoDark.png", width: 150),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_rounded,
              color: Colors.black,
              size: 24,
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded, color: Colors.black, size: 24),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout_rounded, color: Colors.black, size: 24),
          ),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: SizedBox(
        height: 110,
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 201, 238, 240),
          iconSize: 24,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, color: Color(0xFFAFADAE)),
              activeIcon: Icon(Icons.home_rounded, color: Colors.black),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark, color: Color(0xFFAFADAE)),
              activeIcon: Icon(Icons.bookmark, color: Colors.black),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded, color: Color(0xFFAFADAE)),
              activeIcon: Icon(Icons.favorite_rounded, color: Colors.black),
              label: "",
            ),
          ],
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }
}
