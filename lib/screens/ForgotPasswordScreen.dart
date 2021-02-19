import 'package:smalltalk/widgets/CustomTextFormField.dart';
import 'package:smalltalk/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "forgotpassword";

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextFormField(
                      labelText: "Email",
                      hintText: "Enter your email.",
                      iconData: FontAwesomeIcons.solidEnvelope,
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.0,
                  ),
                  PrimaryButton(
                      text: "Send Email.",
                      iconData: FontAwesomeIcons.solidEnvelope,
                      onPress: () {
                        print("Send email");
                      }),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
