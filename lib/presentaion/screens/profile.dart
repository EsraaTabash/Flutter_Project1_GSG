import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_book_application/presentaion/screens/login.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString('user_name') ?? 'Guest';
      email = sp.getString('user_email') ?? 'guest@example.com';
    });
  }

  Future<void> _logout() async {
    await LocalAuthService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = (name ?? 'Guest').trim();
    final displayEmail = (email ?? 'guest@example.com').trim();
    final initialChar = displayName.isNotEmpty
        ? displayName.characters.first.toUpperCase()
        : 'U';

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF7F9FA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Color.fromARGB(255, 248, 242, 196),
                  foregroundColor: Colors.black,
                  child: Text(
                    initialChar,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  displayEmail,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFFF7F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.person_outline_rounded,
                color: Color(0xFF00B4BF),
              ),
              title: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Inter",
                ),
              ),
              subtitle: Text(
                displayName,
                style: TextStyle(fontSize: 14, fontFamily: "Inter"),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF7F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                Icons.alternate_email_rounded,
                color: Color(0xFF00B4BF),
              ),
              title: Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: "Inter",
                ),
              ),
              subtitle: Text(
                displayEmail,
                style: TextStyle(fontSize: 14, fontFamily: "Inter"),
              ),
            ),
          ),

          SizedBox(height: 16),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Color(0xFFF7F9FA),
            leading: Icon(Icons.info_outline_rounded, color: Color(0xFF00B4BF)),
            title: Text(
              'About',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
            subtitle: Text(
              'Recipe Book Application',
              style: TextStyle(fontSize: 13, fontFamily: "Inter"),
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Recipe Book',
                applicationVersion: '1.0.0',
                applicationIcon: CircleAvatar(
                  radius: 18,
                  backgroundColor: Color.fromARGB(255, 248, 242, 196),
                  child: Icon(
                    Icons.restaurant_menu_rounded,
                    color: Colors.black,
                  ),
                ),
                children: [
                  Text(
                    'A simple Flutter training project.',
                    style: TextStyle(fontFamily: "Inter"),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: _logout,
            icon: Icon(Icons.logout_rounded),
            label: Text(
              'Logout',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 248, 242, 196),
              foregroundColor: Colors.black,
              minimumSize: Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
