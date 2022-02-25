import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

//TODO: incluir logotipo da empresa
//TODO: traduzir textos

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen(providerConfigs: [
              EmailProviderConfiguration(),
            ]);
          }

          return child;
        },
      ),
    );
  }
}
