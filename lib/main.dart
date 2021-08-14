import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'dashboard.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final cameras = await availableCameras();
  final camera = cameras.first;

  runApp(App(camera));
}

class App extends StatelessWidget {
  App(this.camera);
  final camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Allergy AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.lightBlueAccent,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => new Login(),
        '/dashboard': (_) => new Dashboard(camera: camera),
      },
    );
  }
}