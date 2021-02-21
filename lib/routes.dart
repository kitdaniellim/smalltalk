import 'package:smalltalk/screens/DashboardScreen.dart';
import 'package:smalltalk/screens/ForgotPasswordScreen.dart';
import 'package:smalltalk/screens/LoginScreen.dart';
import 'package:smalltalk/screens/RegistrationScreen.dart';
import 'package:smalltalk/screens/NewMessageScreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  RegistrationScreen.routeName: (BuildContext context) => RegistrationScreen(),
  ForgotPasswordScreen.routeName: (BuildContext context) =>
      ForgotPasswordScreen(),
  DashboardScreen.routeName: (BuildContext context) => DashboardScreen(),
  NewMessageScreen.routeName: (BuildContext context) => NewMessageScreen(),
};
