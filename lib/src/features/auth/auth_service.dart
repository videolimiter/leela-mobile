import 'dart:async';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {
    print("new AuthService");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  // wrappinhg the firebase calls
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  // logs in the user if password matches
  Future loginUser({required String email, required String password}) {
    if (password == 'password123') {
      currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      currentUser = null;
      return Future.value(null);
    }
  }
}
