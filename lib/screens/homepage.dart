import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../utils/utils.dart';
import 'generatorpage.dart';
import 'settings/settings.dart';
import 'vault/vaultpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => Utils(context).onWillPop(),
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: const [
            VaultPage(),
            GeneratorPage(),
            SettingsPage(),
          ],
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style6,
          // backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor!,
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.lock_outline),
        title: "Vault",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.generating_tokens_outlined),
        title: "Generator",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
    ];
  }
}
