import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppScreenLayout extends StatefulWidget {
  const AppScreenLayout({super.key});

  @override
  State<AppScreenLayout> createState() => _AppScreenLayoutState();
}

class _AppScreenLayoutState extends State<AppScreenLayout> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
                username != null
                    ? "This is Mobile Screen \n Username: $username"
                    : "No username found",
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
