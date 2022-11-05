import 'package:flutter/material.dart';

import '../../widgets/custompageroute.dart';
import 'chagepassword.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.dark_mode,
                    ),
                    // color: Theme.of(context).primaryColor,
                    onPressed: () {
                      print('change theme');
                      // context.read<AddPasswordProvider>().deletePassword();
                      // context.read<AddPasswordProvider>().userPasswords = [];
                      // context.read<AddPasswordProvider>().fatchdata;
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildSettingList(
                context: context,
                title: 'Change Password',
                icon: Icons.arrow_forward_ios_outlined,
                ontap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      transitionduration: const Duration(
                        milliseconds: 800,
                      ),
                      direction: AxisDirection.left,
                      child: const ChangePasswordPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingList({
    required String title,
    required IconData icon,
    required BuildContext context,
    required VoidCallback ontap,
  }) {
    return ListTile(
      tileColor: Theme.of(context).highlightColor,
      onTap: ontap,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
