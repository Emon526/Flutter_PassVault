import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../services/databaseservice.dart';

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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
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
            horizontal: size.width * 0.07,
          ),
          child: Form(
            key: _addPasswordformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fill in the details below to save the password',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const Row(
                  children: [
                    Text(
                      'Title ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: titlecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator:
                      RequiredValidator(errorText: 'Title is required').call,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text(
                  'URL',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: urlcontroller,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Row(
                  children: [
                    Text(
                      'User Name ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextFormField(
                  controller: usernamecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator:
                      RequiredValidator(errorText: 'User Name is required')
                          .call,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Row(
                  children: [
                    Text(
                      'Password ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  obscureText: isObsecured,
                  controller: passwordcontroller,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(focus);
                  },
                  validator:
                      RequiredValidator(errorText: 'Password is required').call,
                  decoration: InputDecoration(
                    filled: true,
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
                  height: size.height * 0.02,
                ),
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                  focusNode: focus,
                  controller: notescontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
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
