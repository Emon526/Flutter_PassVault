import 'package:flutter/material.dart';
import 'screens/onboardingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NepPass',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const OnBoardingSceen(),
    );
  }
}
