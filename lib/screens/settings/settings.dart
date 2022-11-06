import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/themeprovider.dart';
import '../../widgets/custompageroute.dart';
import 'chagepassword.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          child: Column(
            children: [
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
              SizedBox(
                height: size.height * 0.01,
              ),
              _buildSettingList(
                context: context,
                title: 'Privacy Policy',
                icon: Icons.arrow_forward_ios_outlined,
                ontap: () {},
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              _buildSettingList(
                context: context,
                title: context.watch<ThemeProvider>().getDarkTheme
                    ? 'Dark Theme'
                    : "Light Theme",
                icon: context.watch<ThemeProvider>().getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                ontap: () {
                  context.read<ThemeProvider>().setTheme =
                      !context.read<ThemeProvider>().getDarkTheme;
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
    return Material(
      color: Theme.of(context).highlightColor,
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        // tileColor: Theme.of(context).highlightColor,
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
      ),
    );
  }
}
