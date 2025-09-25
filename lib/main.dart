import 'package:flutter/material.dart';

import 'Screens/home_page.dart';
import 'Screens/login_page.dart';
import 'Screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginScreen());
  }
}
