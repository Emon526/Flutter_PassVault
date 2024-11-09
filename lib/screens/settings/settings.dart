import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../consts/consts.dart';
import '../../provider/themeprovider.dart';
import '../../utils/utils.dart';
import '../../widgets/selectionbuttonwidget.dart';
import '../auth/chagepassword.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          child: Column(
            children: [
              _buildListtile(
                tiletitle: 'Change Password',
                iconData: Icons.password_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                },
              ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // _buildListtile(
              //   tiletitle: 'Privacy Policy',
              //   iconData: Icons.policy_outlined,
              //   onTap: () {
              //     Utils(context)
              //         .showSnackBar(snackText: 'Privacy Policy Coming Soon');
              //   },
              // ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // _buildListtile(
              //   tiletitle: 'Backup Data',
              //   iconData: Icons.backup_outlined,
              //   onTap: () {
              //     Utils(context).showSnackBar(
              //         snackText: 'Backup Data Feature Coming Soon');
              //   },
              // ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              // _buildListtile(
              //   tiletitle: 'Restore Data',
              //   iconData: Icons.restore_outlined,
              //   onTap: () {
              //     Utils(context).showSnackBar(
              //         snackText: 'Restore Data Feature Coming Soon');
              //   },
              // ),
              SizedBox(
                height: size.height * 0.01,
              ),
              _buildListtile(
                tiletitle: 'Theme',
                iconData:
                    context.watch<ThemeProvider>().themeMode == ThemeMode.system
                        ? Icons.phonelink_setup_outlined
                        : context.watch<ThemeProvider>().themeMode ==
                                ThemeMode.light
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                onTap: () => Utils(context).showCustomDialog(
                  child: _themetileWidget(
                    context: context,
                    size: size,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildListtile({
    required IconData iconData,
    required String tiletitle,
    required Function onTap,
  }) {
    return ListTile(
      onTap: () {
        onTap();
      },
      title: Text(tiletitle),
      trailing: Icon(iconData),
    );
  }

  _themetileWidget({
    required BuildContext context,
    required Size size,
  }) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Theme',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectionButtonWidget(
                    buttontitle: 'System Theme',
                    iconCondition: provider.themeMode == ThemeMode.system,
                    ontap: () {
                      provider.themeMode = ThemeMode.system;
                    },
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  SelectionButtonWidget(
                    iconCondition: provider.themeMode == ThemeMode.light,
                    buttontitle: 'Light Theme',
                    ontap: () {
                      provider.themeMode = ThemeMode.light;
                    },
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  SelectionButtonWidget(
                    iconCondition: provider.themeMode == ThemeMode.dark,
                    buttontitle: 'Dark Theme',
                    ontap: () {
                      provider.themeMode = ThemeMode.dark;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // Widget _buildSettingList({
  //   required String title,
  //   required IconData icon,
  //   required BuildContext context,
  //   required VoidCallback ontap,
  // }) {
  //   return Material(
  //     color: Theme.of(context).highlightColor,
  //     borderRadius: BorderRadius.circular(5),
  //     child: InkWell(
  //       borderRadius: BorderRadius.circular(5),
  //       onTap: ontap,
  //       child: Padding(
  //         padding: const EdgeInsets.all(14.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               title,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             Icon(
  //               icon,
  //               color: Theme.of(context).iconTheme.color,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
