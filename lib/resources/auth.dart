import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:instagram_clone/models/user.dart' as custommodel;

class AuthMethodFirebaseLogic {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Getting USer details from firebase - implemented by a state management using provider
  Future<custommodel.User> getUserDetails() async {
    //* We will recieve details of user according to our model from firebase
    User currentuser = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentuser.uid)
      .get();

    // return custommodel.User(     //? We would've to do for every property so we outscore it by making it in custom model(in users.dart) to save our time
    //   email: (snap.data() as Map<String, dynamic>)['email'],
    //   uid: (snap.data() as Map<String, dynamic>)['uid'],
    //   photoUrl: (snap.data() as Map<String, dynamic>)['photoUrl'],
    //   username: ...,
    //   bio: ...,
    //   followers: ...,
    //   following: ...
    // );
    //*Alternative
    return custommodel.User.passingValue_fromSnap(snap);
  }

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

        custommodel.User user = custommodel.User(   
          email: email, 
          uid: cred.user!.uid, 
          photoUrl: imageUrl,
          username: username, 
          bio: bio, 
          followers: [], 
          following: []
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());  //* Creating map object of user after creating user model in different class and refferencing to it

        // await _firestore.collection('users').doc(cred.user!.uid).set({  //Traditional object passing by making object in function call
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'followings': [],
        //   'imageURL': imageUrl
        // });

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