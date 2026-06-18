import 'package:flutter/material.dart';
import 'package:trabalho_interface/pages/conta_page.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/camera_page.dart';
import 'pages/plantas_page.dart';

void main() {
  runApp(PlantScanApp());
}

class PlantScanApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'PlantScan',

      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(

        primaryColor: Colors.green,

        elevatedButtonTheme: ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),

        ),

      ),

      initialRoute: '/',

      routes: {

        '/': (context) => LoginPage(),

        '/home': (context) => HomePage(),

        '/camera': (context) => CameraPage(),

        '/plantas': (context) => PlantasPage(),

        '/conta': (context) => ContaPage(),

      },

    );
  }
}