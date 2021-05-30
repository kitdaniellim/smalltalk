// @dart=2.9

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smalltalk/widgets/ScreenArguments.dart';
import './screens/LoginScreen.dart';
import './routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('SOMETHING WENT WRONG AAAAAAAAAAAAAAAAAaa');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return SmolTok();
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }
        });
  }
}

class SmolTok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // iconTheme: IconThemeData(
        //   color: Colors.white, //change your color here
        // ),
        canvasColor: Color(0xFFC2E1F2),
        primaryColor: Colors.white,
        // accentColor: Colors.yellow[800],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 18.0),
        ),
      ),
      routes: routes,
      home: LoginScreen(),
    );
  }
}
