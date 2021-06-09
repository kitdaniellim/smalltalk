import 'package:smalltalk/net/firebase.dart';
import 'package:smalltalk/screens/DashboardScreen.dart';
import 'package:smalltalk/screens/LoginScreen.dart';
import 'package:smalltalk/widgets/CustomTextFormField.dart';
import 'package:smalltalk/widgets/PasswordField.dart';
import 'package:smalltalk/widgets/PrimaryButton.dart';
import 'package:smalltalk/widgets/SecondaryButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ForgotPasswordScreen.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "registration";
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

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
                      controller: _fNameController),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      labelText: "Last Name",
                      hintText: "Last Name",
                      iconData: FontAwesomeIcons.user,
                      controller: _lNameController),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomTextFormField(
                      labelText: "Email",
                      hintText: "Email",
                      iconData: FontAwesomeIcons.user,
                      controller: _emailController,
                      inputType: "email",),
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
                      controller: _passwordController),
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
                      controller: _confirmPasswordController),
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
                            onPress: () async {
                              if(_passwordController.text != _confirmPasswordController.text) {
                                SnackBar snackBar = SnackBar(
                                    content: Text("Passwords do not match."),
                                    backgroundColor: Colors.red);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                               print("Passwords don't match.") ;
                              } else {
                                try{
                                  UserCredential creds = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                                  User user = FirebaseAuth.instance.currentUser;

                                  if(user != null) {
                                    user.updateProfile(displayName: _fNameController.text + ' ' + _lNameController.text);
                                    register(
                                      displayName: _fNameController.text + ' ' + _lNameController.text,
                                      url: ''
                                    );
                                    Navigator.of(context).pushNamed(DashboardScreen.routeName);
                                  }
                                } on FirebaseAuthException catch(e) {
                                  SnackBar snackBar = SnackBar(
                                    content: Text("There was an error with your registration. Please try again later."),
                                    backgroundColor: Colors.red);
                                  if(e.code == 'week-password') {
                                    snackBar = SnackBar(
                                    content: Text("The password provided is too weak."),
                                    backgroundColor: Colors.red);
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    snackBar = SnackBar(
                                    content: Text("An account alredy exists for that email."),
                                    backgroundColor: Colors.red);
                                    print('An account already exists for that email.');
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } catch(e) {
                                  SnackBar snackBar = SnackBar(
                                    content: Text("There was an error with your registration. Please try again later."),
                                    backgroundColor: Colors.red);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  print(e);
                                }
                              }
                              
                              //authenticate here
                              // Navigator.pushReplacementNamed(
                              //     context, DashboardScreen.routeName);
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
