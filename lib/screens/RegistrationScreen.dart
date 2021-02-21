import 'package:smalltalk/screens/LoginScreen.dart';
import 'package:smalltalk/widgets/CustomTextFormField.dart';
import 'package:smalltalk/widgets/PasswordField.dart';
import 'package:smalltalk/widgets/PrimaryButton.dart';
import 'package:smalltalk/widgets/SecondaryButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ForgotPasswordScreen.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "registration";
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      FontAwesomeIcons.cloud,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  CustomTextFormField(
                      labelText: "First Name",
                      hintText: "First Name",
                      iconData: FontAwesomeIcons.user,
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      labelText: "Last Name",
                      hintText: "Last Name",
                      iconData: FontAwesomeIcons.user,
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      labelText: "Email",
                      hintText: "Email",
                      iconData: FontAwesomeIcons.user,
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                      obscureText: _obscurePassword,
                      onTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      labelText: "Password",
                      hintText: "Password",
                      controller: TextEditingController()),
                  SizedBox(
                    height: 20.0,
                  ),
                  PasswordField(
                      obscureText: _obscureConfirmPassword,
                      onTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      labelText: "Confirm Password",
                      hintText: "Confirm Password.",
                      controller: TextEditingController()),
                  SizedBox(
                    height: 70.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        PrimaryButton(
                            text: "REGISTER",
                            iconData: FontAwesomeIcons.pencilAlt,
                            onPress: () {
                              //authenticate here
                              // Navigator.pushReplacementNamed(
                              //     context, DashboardScreen.routeName);
                              print('Register button');
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );

    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.transparent,
    //       elevation: 0,
    //     ),
    //     body: Container(
    //       alignment: Alignment.topCenter,
    //       padding: EdgeInsets.symmetric(horizontal: 20.0),
    //       child: Center(
    //         child: SingleChildScrollView(
    //           child: Form(
    //               child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               CustomTextFormField(
    //                   labelText: "First Name",
    //                   hintText:
    //                       "First Name must have a minimum of 4 characters.",
    //                   iconData: FontAwesomeIcons.user,
    //                   controller: TextEditingController()),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               CustomTextFormField(
    //                   labelText: "Last Name",
    //                   hintText:
    //                       "First Name must have a minimum of 4 characters.",
    //                   iconData: FontAwesomeIcons.user,
    //                   controller: TextEditingController()),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               CustomTextFormField(
    //                   labelText: "Email",
    //                   hintText: "Enter a valid email.",
    //                   iconData: FontAwesomeIcons.solidEnvelope,
    //                   controller: TextEditingController()),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               PasswordField(
    //                   obscureText: _obscurePassword,
    //                   onTap: () {
    //                     setState(() {
    //                       _obscurePassword = !_obscurePassword;
    //                     });
    //                   },
    //                   labelText: "Password",
    //                   hintText: "Enter your password",
    //                   controller: TextEditingController()),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               PasswordField(
    //                   obscureText: _obscureConfirmPassword,
    //                   onTap: () {
    //                     setState(() {
    //                       _obscureConfirmPassword = !_obscureConfirmPassword;
    //                     });
    //                   },
    //                   labelText: "Confirm Password",
    //                   hintText: "Your passwords must match.",
    //                   controller: TextEditingController()),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //               PrimaryButton(
    //                   text: "Register",
    //                   iconData: FontAwesomeIcons.solidFolder,
    //                   onPress: () {
    //                     print("Register button");
    //                   }),
    //               // PrimaryButton(
    //               //     text: "Back",
    //               //     iconData: FontAwesomeIcons.solidFolder,
    //               //     onPress: () {
    //               //       Navigator.pop(context);
    //               //     }),
    //               SizedBox(
    //                 height: 20.0,
    //               ),
    //             ],
    //           )),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
