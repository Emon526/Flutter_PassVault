import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../services/databaseservice.dart';
import '../../widgets/custominputfield.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key});

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final focus = FocusNode();
  final titlecontroller = TextEditingController();
  final urlcontroller = TextEditingController(text: 'https://www.');
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final notescontroller = TextEditingController();
  bool isObsecured = true;
  final GlobalKey<FormState> _addPasswordformKey = GlobalKey<FormState>();

  void validate(BuildContext context) async {
    final FormState form = _addPasswordformKey.currentState!;

    if (form.validate()) {
      DateTime now = DateTime.now().toLocal();
      // DateTime formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

      final newPass = AddPasswordModel(
        title: titlecontroller.text.trim(),
        url: urlcontroller.text.trim(),
        username: usernamecontroller.text.trim(),
        password: passwordcontroller.text.trim(),
        notes: notescontroller.text.trim(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        addeddate: now,
      );
      context.read<DatabaseService>().addPassword(
            password: newPass,
          );
      context.read<AddPasswordProvider>().userPasswords = [];
      context.read<AddPasswordProvider>().fatchdata;
      Navigator.pop(context);
    } else {
      const snackbar = SnackBar(
        content: Text("Please enter all required fields."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    urlcontroller.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    notescontroller.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Password',
        ),
        actions: [
          TextButton(
            onPressed: () {
              validate(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          child: Form(
            key: _addPasswordformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fill in the details below to save the password',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                CustomInputField(
                  isRequired: true,
                  fieldTitle: 'Title',
                  textCapitalization: TextCapitalization.sentences,
                  controller: titlecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator:
                      RequiredValidator(errorText: 'Title is required').call,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomInputField(
                  isRequired: false,
                  fieldTitle: 'URL',
                  controller: urlcontroller,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomInputField(
                  isRequired: true,
                  fieldTitle: 'User Name',
                  controller: usernamecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator:
                      RequiredValidator(errorText: 'User Name is required')
                          .call,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomInputField(
                  isRequired: true,
                  fieldTitle: 'Password',
                  controller: passwordcontroller,
                  obscureText: isObsecured,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validator:
                      RequiredValidator(errorText: 'Password is required').call,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
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
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(focus);
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomInputField(
                  isRequired: false,
                  fieldTitle: 'Notes',
                  controller: notescontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  maxLines: 2,
                  focusNode: focus,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      validate(context);
                    },
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
