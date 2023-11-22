import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class AuthProvider extends ChangeNotifier {
  String? _username;
  String? _password;
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

  Future<void> doLogin(String email, String password) async {
    const userPoolId = 'eu-central-1_qty1MSMmG';
    const clientId = '42ga53kdanbhav6i2gs9ko4lsb';
    final userPool = CognitoUserPool(
      userPoolId,
      clientId,
    );
    final authDetails =  AuthenticationDetails(
      username: email,
      password: password,
    );
    final cognitoUser =  CognitoUser(
      email,
      userPool,
      clientSecret: '1q800lvngevfkd5joe31ldo06hvdp160o2pplbhs6edmtb4b3o7d'
    );
    try {
        print('Before authentication - Username: $email');

      final authResult = await cognitoUser.authenticateUser(authDetails);
      _token = authResult!.getAccessToken().getJwtToken();
      _username = email;
      _password = password;
      notifyListeners();
    } catch (e) {
      print('Errore durante l\'autenticazione: $e');
      _token = null;
    }
  }

  void doLogout() {
    _token = null;
    _username = null;
    _password = null;
    notifyListeners();
  }
}
