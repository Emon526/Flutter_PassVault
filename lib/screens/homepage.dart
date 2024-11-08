import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/navbarprovider.dart';
import '../utils/utils.dart';
import '../widgets/slidingclippednavbarwidget.dart';
import 'generatorpage.dart';
import 'settings/settings.dart';
import 'vault/vaultpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pageWidgets = [
      const VaultPage(),
      const GeneratorPage(),
      const SettingsPage(),
    ];
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) =>
          Utils(context).onWillPop(),
      child:
          Consumer<NavBarProvider>(builder: (context, navBarProvider, child) {
        return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: navBarProvider.pageController,
            children: pageWidgets,
          ),
          bottomNavigationBar: SlidingClippedNavBarWidget(
            selectedIndex: navBarProvider.selectedIndex,
            onItemSelected: (index) => navBarProvider.selectedIndex = index,
            navBarIcon: navBarProvider.icons,
            navBarTitle: navBarProvider.pages,
          ),
        );
      }),
    );
  }
}
