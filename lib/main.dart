import 'package:allergy_ai_app/result.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'dashboard.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final cameras = await availableCameras();

  runApp(App(cameras));
}

class App extends StatelessWidget {
  App(this.cameras);
  final cameras;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allergy AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff003366),
        accentColor: Color(0xffAA4465),
        backgroundColor: Color(0xffF0F0F0),
        scaffoldBackgroundColor: Color(0xffF0F0F0),
        primaryColorDark: Color(0xff3A3B3C),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => new Login(),
        '/dashboard': (_) => new Dashboard(cameras: cameras),
      },
    );
  }
}