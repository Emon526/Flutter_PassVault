// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../services/databaseservice.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key});
  static const routeName = '/AddPassword';

  @override
  State<AddPassword> createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final titlecontroller = TextEditingController(text: 'asfdad');
  final urlcontroller =
      TextEditingController(text: 'https://www.facebook.com/emon.asrafulislam');
  final usernamecontroller = TextEditingController(text: 'faeba');
  final passwordcontroller = TextEditingController(text: 'iugdsaiuga');
  final notescontroller = TextEditingController(text: 'ydfvaysd');
  bool isObsecured = true;
  final GlobalKey<FormState> _addPasswordformKey = GlobalKey<FormState>();

  void validate(BuildContext context) async {
    final FormState form = _addPasswordformKey.currentState!;
    // final DatabaseService _databaseService = DatabaseService();

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              validate(context);
            },
            child: const Text('Save'),
          )
        ],
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
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
                  'Add Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
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
                Row(
                  children: const [
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
                  controller: titlecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: RequiredValidator(errorText: 'Title is required'),
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
                Row(
                  children: const [
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
                      RequiredValidator(errorText: 'User Name is required'),
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: const [
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
                  validator:
                      RequiredValidator(errorText: 'Password is required'),
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
                  maxLines: 3,
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