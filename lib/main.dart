import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatx/services/auth/auth_gate.dart';
import 'package:minimalchatx/services/auth/login_or_register.dart';
import 'package:minimalchatx/firebase_options.dart';
import 'package:minimalchatx/themes/light_mode.dart';
import 'package:minimalchatx/themes/themes_provider.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create:(context)=>ThemeProvider(),
    child:MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}