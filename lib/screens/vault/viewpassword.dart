import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../services/databaseservice.dart';
import '../../utils/utils.dart';
import '../../widgets/custominputfield.dart';

class ViewPassword extends StatefulWidget {
  const ViewPassword({super.key});

  @override
  State<ViewPassword> createState() => _ViewPasswordState();
}

class _ViewPasswordState extends State<ViewPassword> {
  final focus = FocusNode();
  final titlecontroller = TextEditingController();
  final urlcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final notescontroller = TextEditingController();
  bool isObsecured = true;
  final GlobalKey<FormState> _viewPasswordformKey = GlobalKey<FormState>();

  void validate(BuildContext context) async {
    final FormState form = _viewPasswordformKey.currentState!;

    if (form.validate()) {
      final newPass = AddPasswordModel(
        addeddate: context.read<AddPasswordProvider>().addeddate,
        title: titlecontroller.text.trim(),
        url: urlcontroller.text.trim(),
        username: usernamecontroller.text.trim(),
        password: passwordcontroller.text.trim(),
        notes: notescontroller.text.trim(),
        id: context.read<AddPasswordProvider>().id,
      );
      context
          .read<DatabaseService>()
          .updatePassword(
            password: newPass,
          )
          .then((value) {
        context.read<AddPasswordProvider>().userPasswords = [];

        context.read<AddPasswordProvider>().fatchdata;
      });

      Navigator.pop(context);
    } else {
      const snackbar = SnackBar(
        content: Text("Please enter all required fields."),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void initState() {
    usernamecontroller.text = context.read<AddPasswordProvider>().username;
    titlecontroller.text = context.read<AddPasswordProvider>().title;
    urlcontroller.text = context.read<AddPasswordProvider>().url!;
    passwordcontroller.text = context.read<AddPasswordProvider>().password;
    notescontroller.text = context.read<AddPasswordProvider>().notes!;
    super.initState();
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
        title: Text(
          context.read<AddPasswordProvider>().title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.copy,
            ),
            onPressed: () async => await copyPassword(),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
            ),
            onPressed: () {
              context.read<AddPasswordProvider>().deletePassword();
              context.read<AddPasswordProvider>().userPasswords = [];
              context.read<AddPasswordProvider>().fatchdata;
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          child: Form(
            key: _viewPasswordformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  obscureText: isObsecured,
                  isRequired: true,
                  fieldTitle: 'Password',
                  controller: passwordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(focus);
                  },
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
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomInputField(
                  maxLines: 2,
                  focusNode: focus,
                  isRequired: false,
                  fieldTitle: 'Notes',
                  controller: notescontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      validate(context);
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> copyPassword() async {
    final password = context.read<AddPasswordProvider>().password;
    final utils =
        Utils(context); // Capture the Utils instance before the async call

    Clipboard.setData(
      ClipboardData(text: password),
    ).then((_) {
      utils.showSnackBar(snackText: 'Password copied to clipboard');
    });
  }
}
