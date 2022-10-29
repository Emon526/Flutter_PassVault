import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passvault/provider/addpasswordprovider.dart';
import 'package:passvault/screens/vault/vaultpage.dart';
import 'package:passvault/services/databaseservice.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/login.dart';
import 'screens/onboardingpage.dart';

int? isviewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseService(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NepPass',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          home: isviewed != 0 ? const OnBoardingSceen() : const LoginPage(),
          // home: isviewed != 0 ? const OnBoardingSceen() : const VaultPage(),
        );
      },
    );
  }
}
