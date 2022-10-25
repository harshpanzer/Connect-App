import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hierr/homepage.dart';
import 'package:hierr/regis.dart';
import 'package:hierr/regis1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => Login(),
          'regis': (context) => Regis(),
          'homepage': ((context) => Homepage())
        }); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
