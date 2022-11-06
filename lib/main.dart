import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'consts/style.dart';
import 'provider/addpasswordprovider.dart';
import 'provider/generatedpassswordprovideer.dart';
import 'provider/themeprovider.dart';
import 'screens/auth/login.dart';
import 'screens/homepage.dart';
import 'screens/onboardingpage.dart';
import 'services/databaseservice.dart';

int? isviewed;
void main() async {
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   // statusBarColor: Colors.transparent,
  //   statusBarIconBrightness: Brightness.light,
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();
  void checkCurrentTheme() async {
    themeProvider.setTheme = await themeProvider.themePrefrences.getTheme();
  }

  @override
  void initState() {
    checkCurrentTheme();
    super.initState();
  }

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
        ChangeNotifierProvider(
          create: (context) => GeneratedPasswordProvider(),
        ),
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        }),
      ],
      builder: (context, child) {
        context.read<AddPasswordProvider>().fatchdata;
        //context.read<GeneratedPasswordProvider>().generatePassword;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NepPass',
          // theme: ThemeData(
          //   primarySwatch: Colors.deepOrange,
          // ),
          theme: Styles.themeData(
              context.watch<ThemeProvider>().getDarkTheme, context),
          // home: isviewed != 0 ? const OnBoardingSceen() : const LoginPage(),
          home: isviewed != 0 ? const OnBoardingSceen() : const HomePage(),
        );
      },
    );
  }
}
