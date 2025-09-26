import 'package:flutter/material.dart';
import 'package:mcs_bab_3/provider/app_provider.dart';
import 'package:mcs_bab_3/screens/home_page.dart';
import 'package:mcs_bab_3/screens/login_page.dart';
import 'package:provider/provider.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return StreamBuilder(
          stream: appProvider.firebaseAuthentication.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        );
      },
    );
  }
}
