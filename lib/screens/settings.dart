import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('TrashPage'),
      // ),
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
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildSettingList(
                context: context,
                title: ' Dark Theme',
                icon: Icons.dark_mode,
                ontap: () {
                  print('change theme');
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
