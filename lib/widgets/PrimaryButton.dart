import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPress;
  PrimaryButton(
      {required this.text, required this.iconData, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      minWidth: double.maxFinite,
      height: 48,
      child: ElevatedButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Uncomment if we want icons - Daniel
            // Icon(iconData),
            // SizedBox(
            //   width: 10.0,
            // ),
            Text(
              text,
              style: TextStyle(
                color: Color(0xFF8DA5B1),
                fontFamily: 'Quicksand',
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
