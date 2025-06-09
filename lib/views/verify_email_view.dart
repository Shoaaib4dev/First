import 'package:flutter/material.dart';
import 'package:ghj/constants/routes.dart';
import 'package:ghj/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text('we\'ve sent you an email verification'),
          Text('if you haven\'t recieve an email peress button below'),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();              
            },
            child: Text('send email verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logout();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }
}
