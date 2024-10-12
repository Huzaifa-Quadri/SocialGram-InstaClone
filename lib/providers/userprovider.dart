import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethodFirebaseLogic _authmethod = AuthMethodFirebaseLogic();

  // User get getUser => _user!; //!here value is getting null before getting initialized [null check operator used on a null value]

  // Future<void> refreshUser() async {
  //   User user = await _authmethod.getUserDetails();

  //   _user = user; 
  //   notifyListeners();
  // }

  //* Works perfectly as not using null check operator and wating cuz of implementing consumers
  User? get getUser => _user;  // Remove the null check operator

  Future<void> refreshUser() async {
    try {
      User user = await _authmethod.getUserDetails();  // Fetch user details from Firebase
      _user = user;  // Update the _user variable
    } catch (e) {
      print(' ????????????????????????? Error refreshing user data: $e ??????????????????????');
    }
// Ensure this is called to update listeners
  }
}
