import 'package:smalltalk/screens/DashboardScreen.dart';
import 'package:smalltalk/screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/CustomTextFormField.dart';
import '../widgets/PasswordField.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "login";
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();  

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
                      size: 70.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  CustomTextFormField(
                      labelText: "Email or Phone",
                      hintText: "Email or Phone.",
                      iconData: FontAwesomeIcons.solidEnvelope,
                      controller: _emailController),
                  SizedBox(
                    height: 30.0,
                  ),
                  PasswordField(
                      obscureText: _obscureText,
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      labelText: "Password",
                      hintText: "Password",
                      controller: _passwordController),
                  SizedBox(
                    height: 90.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        PrimaryButton(
                            text: "LOGIN",
                            iconData: FontAwesomeIcons.doorOpen,
                            onPress: () async {
                              try {
                                UserCredential creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text
                                );

                                User user = creds.user;

                                if(user != null) {
                                  Navigator.of(context).pushNamed(DashboardScreen.routeName);
                                }
                              } on FirebaseAuthException catch(e) {
                                if(e.code == 'user-not-found') {
                                  print('No user found for that email');
                                } else if (e.code == 'wrong-password') {
                                  print("Wrong password provided for that user.");
                                }
                              } catch (e) {
                                print(e);
                              }
                              //authenticate here
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        PrimaryButton(
                            text: "SIGN UP",
                            iconData: FontAwesomeIcons.pencilAlt,
                            onPress: () {
                              //authenticate here
                              Navigator.pushNamed(
                                  context, RegistrationScreen.routeName);
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
  }
}
