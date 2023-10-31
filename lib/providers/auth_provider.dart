import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
   String? _username;
  String? _password;
  String? _sessionType;
  String? _action;
  String? _token;

  String? get username {
    return _username;
  }

  String? get password {
    return _password;
  }

  bool get isLoggedIn {
    return token != null;
  }

  String? get token {
    return _token;
  }

  String? get sessionType {
    return _sessionType;
  }

  String? get action {
    return _action;
  }


  void doLogin( String email, String password) {
    if(email == 'admin@admin.it' && password == 'admin') {
      _token = '0000';
  } else {
    _token = null;
  }
  }
}