import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  String hintName = '';
  bool isPassword = false;
  TextEditingController controller = TextEditingController();
  String? Function(String?)? validator;

  Customtextfield({
    super.key,
    required this.hintName,
    required this.controller,
    required this.isPassword,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hintName,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF00B4BF), width: 2),
        ),
      ),
    );
  }
}
