import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcs_bab_3/provider/app_provider.dart';
import 'package:mcs_bab_3/screens/auth_gate_page.dart';
import 'package:mcs_bab_3/services/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      child: MaterialApp(
        title: 'MCS BAB 3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: AuthGatePage(),
      ),
    );
  }
}
