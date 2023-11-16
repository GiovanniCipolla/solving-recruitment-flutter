import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({super.key});

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;
  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.5)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: Text(
                  "Welcome!!",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.fromLTRB(20, 280, 20, 10),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Solving Recruitment',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Image.asset(
                            'assets/images/logoNavbarCoge.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        thickness: 2,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100),
                          ),
                          labelText: "Email",
                          enabledBorder: InputBorder.none,
                          labelStyle: const TextStyle(color: Colors.grey),
                        ),
                        controller: emailController,
                      ),
                      TextField(
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100),
                          ),
                          labelText: "Password",
                          enabledBorder: InputBorder.none,
                          labelStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText ?
                              Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                        controller: passwordController,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                    child: Text(
                      "FORGOT PASSWORD?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.amber,
                              onTap: () {
                                String email = emailController.text;
                                String password = passwordController.text;

                                loginProvider.doLogin(email, password);

                                if (loginProvider.isLoggedIn) {
                                  Navigator.pushNamed(
                                      context, Home.routeName);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Credenziali non valide. Riprova.',
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        onPressed: () {},
                        mini: true,
                        elevation: 0,
                        child: const Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "DON'T HAVE AN ACCOUNT ? ",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      " SIGN UP",
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
