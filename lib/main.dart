import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/app_screen_layout.dart';
import 'package:instagram_clone/responsive/reponsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/utils/theme_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const ReponsiveLayoutScreen(
        appScreenLayout: AppScreenLayout(),
        webScreenLayout: WebScreenLayout(),
        
      ),
    );
  }
}
