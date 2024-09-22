import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethodFirebaseLogic{
  final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   
  //Signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      //* registering user on firebase authentication with email and password
      if (email.isNotEmpty ||
          (username.isNotEmpty && username.length > 5) ||
          password.isNotEmpty ||
          (bio.isNotEmpty && bio.length > 10)) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        final String imageUrl = await StorageMethod().uploadImagetoStorage("profile_photo", file, false);

        print(cred.toString());
        print(cred.user!.uid);

        //* add user to firebase database
        
        await _firestore.collection('users').doc(cred.user!.uid).set({  //Outscoring the json formation of user model
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'followings': [],
          'imageURL': imageUrl  //* putting image url for later refferencing
        });

        res = "success";
      }
    } catch (thrownerror) {
      res = thrownerror.toString();
    }
    return res;
  }

  //* User Sign in Logic
  Future<String> signInUser({
    required email,
    required password,
  }) async {
    String res = "Some error occured";
    try {
      //* signing in user after firebase authentication with email and password
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
        //? No need for usercredentials for now

        res = "success";
      } else {
        return "Please Enter the Credentials";
      }
    } catch (thrownerror) {
      res = thrownerror.toString();
    }
    return res;
  }

}