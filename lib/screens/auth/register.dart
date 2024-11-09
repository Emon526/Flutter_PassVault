import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../provider/authprovider.dart';
import '../../provider/onboardprovider.dart';
import '../../utils/utils.dart';
import '../../widgets/customelevatedbutton.dart';
import '../homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final focus = FocusNode();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _registerformKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character'),
  ]);
  final passwordMatchValidator =
      MatchValidator(errorText: 'Passwords do not match');

  @override
  void dispose() {
    passwordController.dispose();
    confirmpasswordController.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthProvider>(
        builder: (BuildContext context, provider, Widget? child) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic) =>
            Utils(context).onWillPop(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: Form(
                  key: _registerformKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      SvgPicture.asset(
                        'assets/secure_files.svg',
                        height: size.height * 0.2,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Register a master password',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      TextFormField(
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(focus);
                        },
                        obscureText: provider.isObsecured,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator: passwordValidator.call,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                            child: Icon(
                              provider.isObsecured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onTap: () {
                              provider.isObsecured = !provider.isObsecured;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      TextFormField(
                        focusNode: focus,
                        obscureText: provider.isObsecured,
                        controller: confirmpasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        validator: (val) =>
                            passwordMatchValidator.validateMatch(
                                val!, passwordController.text.trim()),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: InkWell(
                            child: Icon(
                              provider.isObsecured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onTap: () {
                              provider.isObsecured = !provider.isObsecured;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      CustomElevatedButton(
                        ontap: () {
                          validate();
                        },
                        buttontext: 'Register',
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Divider(color: Theme.of(context).primaryColor),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Note that if the master password is lost,the stored '
                        'data cannot be recovered because of the missing '
                        'sync option. it is strongly recommended that you '
                        'backup your  data at regular intervals.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    });
  }

  void validate() async {
    final FormState form = _registerformKey.currentState!;
    if (form.validate()) {
      context.read<OnBoardingProvider>().isBoardingCompleate = true;
      context
          .read<AuthProvider>()
          .savePassword(password: confirmpasswordController.text.trim());

      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }
}
