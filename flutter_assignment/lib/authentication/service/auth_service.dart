import 'dart:convert';

import 'package:assignment/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signIn(String username, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  SharedPreferences prefs;
  @override
  Future<User> getCurrentUser() async {
    prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('user');
    return User(username); // return null for now
  }

  @override
  Future<User> signIn(String username, String password) async {
    await Future.delayed(Duration(seconds: 2)); // simulate a network delay

    if ((username != '9898989898' ||username != '9876543210') && password != 'password123') {
      throw Exception('Invalid username or password');
    }
    await prefs.setString('user', username);
    return User(username);
  }

  @override
  Future<void> signOut() {
    return null;
  }
}