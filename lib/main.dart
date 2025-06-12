import 'package:flutter/material.dart';
import 'package:ghj/constants/routes.dart';
import 'package:ghj/services/auth/auth_service.dart';
import 'package:ghj/services/auth/crud/notes_service.dart';
import 'package:ghj/views/login_view.dart';
import 'package:ghj/views/notes/create_update_note_view.dart';
import 'package:ghj/views/notes/notes_view.dart';
import 'package:ghj/views/register_view.dart';
import 'package:ghj/views/verify_email_view.dart';

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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          //  if (user?.emailVerified ?? false) {
          //    return const Text('Done');
          // } else {
          //    return const VerifyEmailView();
          //  }

          default:
            return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
