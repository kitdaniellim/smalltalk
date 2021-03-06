import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;
  final String inputType;

  CustomTextFormField(
      {required this.labelText,
      required this.hintText,
      required this.iconData,
      required this.controller,
      this.inputType = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // Uncomment if we want icons - Daniel
        // prefixIcon: Container(
        //   padding: EdgeInsets.symmetric(horizontal: 20.0),
        //   child: Icon(
        //     iconData,
        //   ),
        // ),

        // labelText: labelText,

        hintStyle: TextStyle(
          color: Color(0xFF8DA5B1),
          fontFamily: 'Quicksand',
          fontSize: 17.0,
        ),
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => EmailValidator.validate(value) && inputType == 'email' ? null : "Please enter a valid email",
      controller: controller,
    );
  }
}
