import 'package:flutter/material.dart';
import 'package:ghj/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ghj/views/login_view.dart';
import 'package:ghj/views/register_view.dart';

void main() {
  //  main function returns what displayed on screen
  WidgetsFlutterBinding.ensureInitialized(); // make sure everything in initialized
  runApp(
    MaterialApp(
      title: 'Flutter Demo ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          onSecondary: Colors.red,
        ),
      ),
      home: const HomePage(),
      routes: {
        "/login/": (context) => const LoginView(),
        "/register/": (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //  final user = FirebaseAuth.instance.currentUser;

            //  if (user?.emailVerified ?? false) {
            //    return const Text('Done');
            // } else {
            //    return const VerifyEmailView();
            //  }

            return LoginView();
          default:
            return const Text("Loading...");
        }
      },
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    );
  }
}


