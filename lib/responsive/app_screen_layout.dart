import 'package:flutter/material.dart';

class AppScreenLayout extends StatefulWidget {
  const AppScreenLayout({super.key});

  @override
  State<AppScreenLayout> createState() => _AppScreenLayoutState();
}

class _AppScreenLayoutState extends State<AppScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("This is Mobile App Interface"),
      ),
    );
  }
}
