import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/presentaion/screens/login.dart';
import 'package:recipe_book_application/presentaion/screens/mainNav.dart';
import 'package:recipe_book_application/presentaion/widgets/customTextFieldWidget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Image.network(
                'https://pathwayport.com/saasland/images/login@4x.png',
                width: 300,
                errorBuilder: (context, error, StackTrace) {
                  return Image.asset("assets/login.png");
                },
              ),
              Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00B4BF),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                  child: Column(
                    children: [
                      Customtextfield(
                        hintName: "NAME",
                        controller: nameController,
                        isPassword: false,
                        validator: (name) {
                          if (name!.isEmpty) {
                            return "NAME IS REQUIRED";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 17),
                      Customtextfield(
                        hintName: "EMAIL",
                        controller: emailController,
                        isPassword: false,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return "EMAIL IS REQUIRED";
                          }
                          if (!email.contains("@") || !email.contains(".")) {
                            return "ENTER A VALID EMAIL";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 17),
                      Customtextfield(
                        hintName: "PHONE NUMBER",
                        controller: phoneController,
                        isPassword: false,
                        validator: (phone) {
                          if (phone!.isEmpty) {
                            return "PHONE NUMBER IS REQUIRED";
                          }
                          if (!phone.startsWith("+970")) {
                            return "ENTER A VALID PHONE NUMBER";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 17),
                      Customtextfield(
                        hintName: "PASSWORD",
                        controller: passwordController,
                        isPassword: true,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return "PASSWORD IS REQUIRED";
                          }
                          if (password.length < 8) {
                            return "PASSWORD MUST BE AT LEAST 8 CHARACTERS";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 34),
                      InkWell(
                        onTap: () {
                          signup();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFF00B4BF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "CREATE ACCOUNT",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Login();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "You have already an account?",
                            style: TextStyle(
                              color: Color(0xFF00B4BF),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signup() {
    if (_formKey.currentState!.validate()) {
      LocalAuthService.signup(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Mainnav(name: nameController.text.trim());
          },
        ),
      );
    }
  }
}
