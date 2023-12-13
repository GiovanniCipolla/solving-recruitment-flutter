import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;
import 'package:solving_recruitment_flutter/costants.dart';
import 'package:solving_recruitment_flutter/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User? _user;
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

  User? get user {
    return _user;
  }

  Future<void> _saveCredentials(String email, String password) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
  }

  Future<void> _removeCredentials() async {
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'password');
  }

  Future<void> tryLogin() async {
    final savedEmail = await _storage.read(key: 'email');
    final savedPassword = await _storage.read(key: 'password');

    if (savedEmail != null && savedPassword != null) {
      await doLogin(savedEmail, savedPassword);
    }
  }

  Future<void> doLogin(String email, String password) async {
    const userPoolId = 'eu-central-1_qty1MSMmG';
    const clientId = '42ga53kdanbhav6i2gs9ko4lsb';
    final userPool = CognitoUserPool(
      userPoolId,
      clientId,
    );
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    final cognitoUser = CognitoUser(email, userPool,
        clientSecret: '1q800lvngevfkd5joe31ldo06hvdp160o2pplbhs6edmtb4b3o7d');
    try {
      final authResult = await cognitoUser.authenticateUser(authDetails);
      _token = authResult!.getAccessToken().getJwtToken();
      _username = email;
      _password = password;
      notifyListeners();
    } catch (e) {
      print('Errore durante l\'autenticazione: $e');
      _token = null;
    }

    await sendToken(_token!)
        ?  _saveCredentials(email, password)
        : _token = null;
  }

  void doLogout() {
    _token = null;
    _username = null;
    _password = null;
    _removeCredentials();
    notifyListeners();
  }

  Future<bool> sendToken(token) async {
    String url = '$urlAPI/user/currentUser?tokenId=$token';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      _user = User.fromJson(jsonData);
      return true;
    } else {
      return false;
    }
  }
}
