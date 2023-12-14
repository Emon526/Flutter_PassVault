// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/themeprovider.dart';
import '../../widgets/custombutton.dart';
import '../homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final passwordController = TextEditingController();
  Future<void> _checkPassword(String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final masterpassword = prefs.getString('password');
    if (masterpassword == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      const snackbar = SnackBar(
        content: Text("Password not matched"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void validate(String password, BuildContext context) async {
    final FormState form = _loginformKey.currentState!;
    if (form.validate()) {
      await _checkPassword(password, context);
    } else {
      const snackbar = SnackBar(
        content: Text("Invalid form data"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  bool isObsecured = true;
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: context.watch<ThemeProvider>().getDarkTheme
            ? Colors.black
            : Colors.white,
        statusBarIconBrightness: context.watch<ThemeProvider>().getDarkTheme
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07,
              ),
              child: Form(
                key: _loginformKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    SvgPicture.asset(
                      'assets/secure_login.svg',
                      height: size.height * 0.2,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      'Enter master password and login',
                      style: TextStyle(
                        // fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    TextFormField(
                      obscureText: isObsecured,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: passwordValidator.call,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        border: const OutlineInputBorder(),
                        suffix: InkWell(
                          child: Icon(
                            isObsecured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onTap: () {
                            setState(() {
                              isObsecured = !isObsecured;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomButton(
                      ontap: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        validate(passwordController.text.trim(), context);
                      },
                      buttontext: 'Login',
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const Text(
                      'Once you save a password in NepPass. you\'ll '
                      'always have it when you need it. logging in is fast '
                      'and easy.',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
