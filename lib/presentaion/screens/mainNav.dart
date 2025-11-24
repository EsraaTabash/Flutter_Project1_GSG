import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/presentaion/screens/MyRecipes.dart';
import 'package:recipe_book_application/presentaion/screens/allRecipes.dart';
import 'package:recipe_book_application/presentaion/screens/favourite.dart';
import 'package:recipe_book_application/presentaion/screens/home.dart';
import 'package:recipe_book_application/presentaion/screens/login.dart';
import 'package:recipe_book_application/presentaion/screens/profile.dart';
import 'package:recipe_book_application/presentaion/widgets/drawer_item.dart';

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
      Myrecipes(),
      Favourite(),
      Profile(),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Color.fromARGB(255, 201, 238, 240),
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
          // IconButton(
          //   onPressed: () {
          //     LocalAuthService.logout();
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return Login();
          //         },
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.logout_rounded, color: Colors.black, size: 24),
          // ),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 201, 238, 240),
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
              icon: Icon(
                Icons.restaurant_menu_rounded,
                color: Color(0xFFAFADAE),
              ),
              activeIcon: Icon(
                Icons.restaurant_menu_rounded,
                color: Colors.black,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded, color: Color(0xFFAFADAE)),
              activeIcon: Icon(Icons.menu_book_rounded, color: Colors.black),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded, color: Color(0xFFAFADAE)),
              activeIcon: Icon(Icons.favorite_rounded, color: Colors.black),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded, color: Color(0xFFAFADAE)),
              activeIcon: Icon(Icons.person_rounded, color: Colors.black),
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
      drawer: Drawer(
        width: 300,
        backgroundColor: Color(0xFFF7F9FA),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 201, 238, 240),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/logoDark.png", width: 160),
                    SizedBox(height: 12),
                    Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontFamily: "Inter",
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.name ?? "Guest",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                ),
              ),

              DrawerItemWidget(
                icon: Icons.home_rounded,
                label: "Home",
                isSelected: index == 0,
                onTap: () => setState(() => index = 0),
              ),
              DrawerItemWidget(
                icon: Icons.restaurant_menu_rounded,
                label: "Recipes",
                isSelected: index == 1,
                onTap: () => setState(() => index = 1),
              ),
              DrawerItemWidget(
                icon: Icons.menu_book_rounded,
                label: "My Recipes",
                isSelected: index == 2,
                onTap: () => setState(() => index = 2),
              ),
              DrawerItemWidget(
                icon: Icons.favorite_rounded,
                label: "Favourites",
                isSelected: index == 3,
                onTap: () => setState(() => index = 3),
              ),
              DrawerItemWidget(
                icon: Icons.person_rounded,
                label: "Profile",
                isSelected: index == 4,
                onTap: () => setState(() => index = 4),
              ),

              Spacer(),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.logout_rounded, color: Colors.black87),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  LocalAuthService.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
