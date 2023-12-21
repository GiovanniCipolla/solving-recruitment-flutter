import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solving_recruitment_flutter/providers/academy.provider.dart';
import 'package:solving_recruitment_flutter/providers/annuncio_provider.dart';
import 'package:solving_recruitment_flutter/providers/area_provider.dart';
import 'package:solving_recruitment_flutter/providers/auth_provider.dart';
import 'package:solving_recruitment_flutter/providers/candidato_provider.dart';
import 'package:solving_recruitment_flutter/providers/colloquio_provider.dart';
import 'package:solving_recruitment_flutter/providers/selezionatore_provider.dart';
import 'package:solving_recruitment_flutter/providers/tipologia_annuncio_provider.dart';
import 'package:solving_recruitment_flutter/screens/academy_screens/academy_screen.dart';
import 'package:solving_recruitment_flutter/screens/annuncio_screens/annuncio_screen.dart';
import 'package:solving_recruitment_flutter/screens/area_screens/area_screen.dart';
import 'package:solving_recruitment_flutter/screens/candidato_screens/candidato_screen.dart';
import 'package:solving_recruitment_flutter/screens/colloquio_screens/colloquio_screen.dart';
import 'package:solving_recruitment_flutter/screens/home.dart';
import 'package:solving_recruitment_flutter/screens/login_screen.dart';
import 'package:solving_recruitment_flutter/screens/selezionatore_screens/selezionatore_screen.dart';
import 'package:solving_recruitment_flutter/screens/tipologia_annuncio_screens/tipologia_annuncio.dart';

// --------------------------------- TODO

// 1) -- Implementare Academy , screen e tutta la logica
// 2) -- Soluzione se ci sono errori , che avvisi dare
// 3) -- Lista candidati in annuncio , da tutti anche quelli eliminati

// ---------------------------------  TODO EXTRA
// Nei filtri aggiungere parametri
// Quando si fa l'update , bisogna ritornare nel details del candidato stesso

// --------------------------------- PROBLEMI
// Problema flutter nel download del cv, per correggere aspettare il run del remoto!!
// Lista candidati in annuncio , da tutti anche quelli eliminati

final kColorScheme = ColorScheme.fromSwatch(
  primarySwatch: const MaterialColor(
    0xFF2DB264,
    <int, Color>{
      50: Color(0xFF2DB264),
      100: Color(0xFF2DB264),
      200: Color(0xFF2DB264),
      300: Color(0xFF2DB264),
      400: Color(0xFF2DB264),
      500: Color(0xFF2DB264),
      600: Color(0xFF2DB264),
      700: Color(0xFF2DB264),
      800: Color(0xFF2DB264),
      900: Color(0xFF2DB264),
    },
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, AnnuncioProvider>(
          create: (ctx) => AnnuncioProvider(
              authProvider: null, annunci: [], candidati: [], area: null),
          update: (ctx, authProvider, previous) => AnnuncioProvider(
            authProvider: authProvider,
            annunci: previous!.annunci,
            candidati: previous.candidati,
            area: previous.area,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CandidatoProvider>(
            create: (ctx) =>
                CandidatoProvider(authProvider: null, candidati: []),
            update: (ctx, authProvider, previous) => CandidatoProvider(
                authProvider: authProvider, candidati: previous!.candidati)),
        ChangeNotifierProxyProvider<AuthProvider, AreaProvider>(
          create: (ctx) => AreaProvider(
              authProvider: null, aree: [], candidati: [], annunci: []),
          update: (ctx, authProvider, previous) => AreaProvider(
            authProvider: authProvider,
            aree: previous!.aree,
            candidati: previous.candidati,
            annunci: previous.annunci,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, SelezionatoreProvider>(
          create: (ctx) =>
              SelezionatoreProvider(authProvider: null, selezionatori: []),
          update: (ctx, authProvider, previous) => SelezionatoreProvider(
              authProvider: authProvider,
              selezionatori: previous!.selezionatori),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ColloquioProvider>(
          create: (ctx) => ColloquioProvider(authProvider: null, colloqui: []),
          update: (ctx, authProvider, previous) => ColloquioProvider(
              authProvider: authProvider, colloqui: previous!.colloqui),
        ),
        ChangeNotifierProxyProvider<AuthProvider, TipologiaAnnuncioProvider>(
          create: (ctx) => TipologiaAnnuncioProvider(
              authProvider: null, tipologiaAnnuncio: []),
          update: (ctx, authProvider, previous) => TipologiaAnnuncioProvider(
              authProvider: authProvider,
              tipologiaAnnuncio: previous!.tipologiaAnnuncio),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AcademyProvider>(
            create: (ctx) => AcademyProvider(authProvider: null, academies: []),
            update: (ctx, authProvider, previous) => AcademyProvider(
                authProvider: authProvider, academies: previous!.academies))
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, child) {
          return MaterialApp(
              title: 'Solving Recruitment',
              theme: ThemeData(
                colorScheme: kColorScheme,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                primaryColor: kColorScheme.primary,
                scaffoldBackgroundColor: Colors.white,
                canvasColor: Colors.white,
                dialogBackgroundColor: Colors.white,
              ),
              home: authProvider.isLoggedIn
                  ? const Home()
                  : FutureBuilder(
                      future: authProvider.tryLogin(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const LoginScreen();
                      }),
              routes: {
                LoginScreen.routeName: (ctx) => const LoginScreen(),
                AreaScreen.routeName: (ctx) => const AreaScreen(),
                CandidatoScreen.routeName: (ctx) => const CandidatoScreen(),
                ColloquioScreen.routeName: (ctx) => const ColloquioScreen(),
                AnnuncioScreen.routeName: (ctx) => const AnnuncioScreen(),
                SelezionatoreScreen.routeName: (ctx) =>
                    const SelezionatoreScreen(),
                TipologiaAnnuncioScreen.routeName: (ctx) =>
                    const TipologiaAnnuncioScreen(),
                AcademyScreen.routeName: (ctx) => const AcademyScreen(),
                Home.routeName: (ctx) => const Home(),
              });
        },
      ),
    );
  }
}
