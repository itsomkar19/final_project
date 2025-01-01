import 'dart:io';

import 'package:credbud/http_overrides.dart';
import 'package:credbud/state/auth/providers/is_logged_in_provider.dart';
import 'package:credbud/state/providers/is_loading_provider.dart';
import 'package:credbud/views/components/loading/loading_screen.dart';
import 'package:credbud/views/home_screen/home_screen.dart';
import 'package:credbud/views/welcome_screen/welcome_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp])
      .then((value) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CredBud',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          //take care of displaying loading overlay
          ref.listen(isLoadingProvider, (_, nextIsLoading) {
            if (nextIsLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });

          final isLoggedIn = ref.watch(isLoggedInProvider);
          if (kDebugMode) {
            print('Check for logged in: $isLoggedIn');
          }
          if (isLoggedIn) {
            return const HomeScreen();
          } else {
            return const WelcomeScreenView();
          }
        },
      ),
      routes: {
        "Home": (context) => const HomeScreen(),
      },
    );
  }
}
