import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book_application/cubit/auth_cubit.dart';
import 'package:recipe_book_application/cubit/auth_state.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/presentaion/screens/mainNav.dart';
import 'package:recipe_book_application/presentaion/screens/signup.dart';
import 'package:recipe_book_application/presentaion/widgets/customTextFieldWidget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              FadeInImage(
                placeholder: const AssetImage('assets/login.png'),
                image: const NetworkImage(
                  'https://pathwayport.com/saasland/images/login@4x.png',
                ),
                fit: BoxFit.contain,
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00B4BF),
                ),
              ),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Mainnav(
                            name: state.user.displayName ?? "Guest",
                          );
                        },
                      ),
                    );
                  }
                  if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        duration: Duration(milliseconds: 300),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) => Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                    child: Column(
                      children: [
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
                            login();
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
                                "LOGIN",
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
                                    return Signup();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Don't have an account?",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() {
    if (_formKey.currentState!.validate()) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return Mainnav(name: LocalAuthService.getUserName() ?? "Guest");
      //     },
      //   ),
      // );
      context.read<AuthCubit>().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }
}
