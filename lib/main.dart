import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passvault/screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboardingpage.dart';

int? isviewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
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
      home: isviewed != 0 ? const OnBoardingSceen() : const LoginPage(),
    );
  }
}
