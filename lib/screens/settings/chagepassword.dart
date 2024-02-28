import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/consts.dart';
import '../../widgets/custombutton.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isObsecured = true;
  final focus = FocusNode();
  _savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  void validate(BuildContext context) async {
    final FormState form = _loginformKey.currentState!;
    if (form.validate()) {
      await _savePassword(confirmpasswordController.text.trim());
    } else {
      const snackbar = SnackBar(
        content: Text("Form is invalid"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

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
              key: _loginformKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  TextFormField(
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(focus);
                    },
                    obscureText: isObsecured,
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
                          isObsecured ? Icons.visibility : Icons.visibility_off,
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
                    height: size.height * 0.03,
                  ),
                  TextFormField(
                    focusNode: focus,
                    obscureText: isObsecured,
                    controller: confirmpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (val) => MatchValidator(
                            errorText: 'passwords do not match')
                        .validateMatch(val!, passwordController.text.trim()),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Consts.BORDER_RADIUS)),
                      suffix: InkWell(
                        child: Icon(
                          isObsecured ? Icons.visibility : Icons.visibility_off,
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
                    height: size.height * 0.04,
                  ),
                  CustomButton(
                    ontap: () {
                      validate(context);
                      Navigator.pop(context);
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
  }
}
