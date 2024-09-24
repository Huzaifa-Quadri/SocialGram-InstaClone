// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as custommodel;
import 'package:instagram_clone/providers/userprovider.dart';
import 'package:provider/provider.dart';

class AppScreenLayout extends StatefulWidget {
  const AppScreenLayout({super.key});

  @override
  State<AppScreenLayout> createState() => _AppScreenLayoutState();
}

class _AppScreenLayoutState extends State<AppScreenLayout> {
  String? username;

  /*
  * No need for this after setting up provider - it only fetches data once for app and provider data to app as per need
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
  */

  @override
  Widget build(BuildContext context) {
    custommodel.User user = Provider.of<UserProvider>(context).getUser;  //! Value is getting null before initialized, to be solved later
    //with this provider (state management) we can acces any data property anywhere in our app

    return Scaffold(
      body: Center(
        child: Text(
          "Username : ${user.username}\nEmail : ${user.email}",
          style: const TextStyle(color: Colors.white
          ),
        ),
      ),
    );
  }
}
