import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/data/size.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';

class LoginScreen extends StatefulWidget {
    static const String routeName = '/login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final double height = heightSize(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(height * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      authProvider.doLogin(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (authProvider.token != null) {
                      Navigator.pushNamed(context, Home.routeName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                'Login fallito. Controlla le tue credenziali.'),
                          ),
                        );
                      }
                    },
                    child: const Text('Accedi'),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Text(
                    'Recruitment',
                    style: TextStyle(color: Colors.red, fontSize: height * 0.03),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
