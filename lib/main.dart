import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluchat/screens/auth/auth_screen.dart';
import 'package:fluchat/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, appSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color.fromRGBO(7, 94, 84, 1),
              accentColor: Color.fromRGBO(37, 211, 102, 1),
              buttonColor: Colors.blueGrey,
              textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black),
                bodyText2: TextStyle(color: Colors.white),
              ),
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return ChatScreen();
                }
                return AuthScreen();
              },
            ),
          );
        });
  }
}
