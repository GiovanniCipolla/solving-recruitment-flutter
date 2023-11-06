import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';
import 'package:solving_recruitment_flutter/screens/area_screens/area_screen.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/screens/login_screen.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, AnnuncioProvider>(
          create: (ctx) => AnnuncioProvider(authProvider: null, annunci: [], candidati: [], area: null),
          update: (ctx, authProvider, previous) => AnnuncioProvider(
            authProvider: authProvider,
            annunci: previous!.annunci, candidati: [], area: null,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, child) {
          return  MaterialApp(
            title: 'Solving Recruitment',
            home: const LoginScreen(),
            routes: {
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              AreaScreen.routeName: (ctx) => const AreaScreen(),
              CandidatoScreen.routeName: (ctx) => const CandidatoScreen(),
              // ColloquioScreen.routeName: (ctx) => const ColloquioScreen(),
              AnnuncioScreen.routeName: (ctx) => const AnnuncioScreen(),
              SelezionatoreScreen.routeName: (ctx) => const SelezionatoreScreen(),
              // TipologiaAnnuncioScreen.routeName: (ctx) => const TipologiaAnnuncioScreen(),
              Home.routeName: (ctx) => const Home(),
            }
          );
        },
      ),
    );
  }
}