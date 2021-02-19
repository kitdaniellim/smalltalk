import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordField extends StatelessWidget {
  final bool obscureText;
  final Function onTap;
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  PasswordField(
      {@required this.obscureText,
      @required this.onTap,
      @required this.labelText,
      @required this.hintText,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        // Uncomment if we want icons - Daniel
        // prefixIcon: Container(
        //   padding: EdgeInsets.symmetric(horizontal: 15.0),
        //   child: Icon(
        //     FontAwesomeIcons.lock,
        //   ),
        // ),
        suffixIcon: GestureDetector(
          child: Icon(obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color(0xFF8DA5B1)),
          onTap: onTap,
        ),
        // labelText: labelText,
        hintStyle: TextStyle(
          color: Color(0xFF8DA5B1),
          fontFamily: 'Quicksand',
          fontSize: 17.0,
        ),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.only(left: 40.0, right: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
