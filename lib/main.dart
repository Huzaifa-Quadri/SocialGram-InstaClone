import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/responsive/app_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/theme_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    //? try catch block to catch any error if happens in intializing or running app
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "...",  //Hidden for Security reasons
            authDomain: "...",
            projectId: "...",
            storageBucket: "...",
            messagingSenderId: "...",
            appId: "..."
          ),
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
      title: 'SocialGram by FLutter',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayoutScreen(  //* Persisting user after installation (Deleted after n+2 commits)
          //     webScreenLayout: WebScreenLayout(),
          //     appScreenLayout: AppScreenLayout()),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const ResponsiveLayoutScreen(
                      webScreenLayout: WebScreenLayout(),
                      appScreenLayout: AppScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    Center(child: Text("Some internal Error has Occured \n ${snapshot.error}"));
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(child: CircularProgressIndicator());
                }

                return const LoginScreen();
              })
          //! home: const LoginScreen(), //=> In casy of any error(uncomment this line & comment all above)
          /*
        *1. stream: FirebaseAuth.instance.idTokenChanges(), //1st technique -> User token changes or sign in in a new device logout, etc
        *2. stream: FirebaseAuth.instance.userChanges(),  //2nd technique -> all things in 1st method + change on update email, change password, etc
        *3. stream: FirebaseAuth.instance.authStateChanges() //3rd and (simple technique) -> Only runs when user is sign in or sign out
        */
          //* Have to implement persisting user state cuz whenever user will open the app it will sṭart from login screen and not home screen
          //* we want it to check if user is verified by auth and then allow it it directly jump to home screen with not loggin in again
          //? With other database or node.js we have to store other uid or unique identifier in apps memory and then get it everytime and check if user is authenticated or not but firebase instead prvide us some direct implementation methods
    );
  }
}
