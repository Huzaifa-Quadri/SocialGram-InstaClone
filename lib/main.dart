import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/theme_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //? try catch block to catch any error if happens in intializing or running app
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBUyGLAhUWJjt_HUr9kzhCRnaPECPa2PzE",
            authDomain: "instagram-clone-3941b.firebaseapp.com",
            projectId: "instagram-clone-3941b",
            storageBucket: "instagram-clone-3941b.appspot.com",
            messagingSenderId: "10702548179",
            appId: "1:10702548179:web:cb184a6617a2acea56f826"),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (error) {
    print("\n\n\n\n\nSome Error Occured\n ${error.toString()}\n\n\n\n");
  }
  //* Execute Run app when platform isnt web or anything
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
      home: const LoginScreen()
        
    );
  }
}
