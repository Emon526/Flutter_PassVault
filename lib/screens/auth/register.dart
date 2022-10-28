// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custombutton.dart';
import '../homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final passwordController = TextEditingController(text: '1234567@');
final confirmpasswordController = TextEditingController(text: '1234567@');
bool isObsecured = true;
_storeOnboardInfo() async {
  int isViewed = 0;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('onBoard', isViewed);
}

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
    await _storeOnboardInfo();
    await _savePassword(confirmpasswordController.text.trim());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  } else {
    const snackbar = SnackBar(
      content: Text("Form is invalid"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
          ),
          child: Form(
            key: _loginformKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: size.height * 0.3,
                ),
                Text(
                  'Register a master password',
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
                  textInputAction: TextInputAction.next,
                  validator: passwordValidator,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
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
                  obscureText: isObsecured,
                  controller: confirmpasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: (val) =>
                      MatchValidator(errorText: 'passwords do not match')
                          .validateMatch(val!, passwordController.text.trim()),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: const OutlineInputBorder(),
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
                  },
                  buttontext: 'Register',
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Note that if the master password is lost,the stored '
                  'data cannot be recovered because of the missing '
                  'sync option. it is strongly recommended that you '
                  'backup your  data at regular intervals.',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
