import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../../consts/consts.dart';
import '../../provider/authprovider.dart';
import '../../widgets/custombutton.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final focus = FocusNode();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();

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
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Change Password',
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07,
              ),
              child: Form(
                key: _changePasswordFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
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
                        filled: true,
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Consts.BORDER_RADIUS)),
                        suffix: InkWell(
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
                      validator: (val) => passwordMatchValidator.validateMatch(
                          val!, passwordController.text.trim()),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Consts.BORDER_RADIUS)),
                        suffix: InkWell(
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
                    CustomButton(
                      ontap: () {
                        validate();
                      },
                      buttontext: 'Change Password',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void validate() async {
    final FormState form = _changePasswordFormKey.currentState!;
    if (form.validate()) {
      context
          .read<AuthProvider>()
          .savePassword(password: confirmpasswordController.text.trim());
      Navigator.pop(context);
    }
  }
}
