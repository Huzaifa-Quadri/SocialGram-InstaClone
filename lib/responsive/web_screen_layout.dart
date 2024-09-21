import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/theme_layout.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          color: webBackgroundColor,
          child: const Text("This is on web screen")),
      ),
    );
  }
}