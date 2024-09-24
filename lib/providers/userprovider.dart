import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethodFirebaseLogic _authmethod = AuthMethodFirebaseLogic();

  User get getUser => _user!; 

  Future<void> refreshUser() async {
    User user = await _authmethod.getUserDetails();

    _user = user; 
    notifyListeners();
  }
}
