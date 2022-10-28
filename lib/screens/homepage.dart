import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'generatorpage.dart';
import 'trashpage.dart';
import 'vaultpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          VaultPage(),
          GeneratorPage(),
          TrashPage(),
        ],
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.lock_outline),
        title: ("Vault"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.generating_tokens_outlined),
        title: ("Generator"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.delete_outline),
        title: ("Trash"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey.shade600,
      ),
    ];
  }
}



// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int currentIndex = 0;
//   final screens = [
//     const VaultPage(),
//     const GeneratorPage(),
//     const TrashPage(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: IndexedStack(
//       //   index: currentIndex,
//       //   children: screens,
//       // ),
//       body: screens[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Theme.of(context).primaryColor,
//         onTap: (value) {
//           // Respond to item press.
//           setState(() {
//             currentIndex = value;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             label: 'Vault',
//             icon: Icon(Icons.lock_outline),
//           ),
//           BottomNavigationBarItem(
//             label: 'Generator',
//             icon: Icon(Icons.generating_tokens_outlined),
//           ),
//           BottomNavigationBarItem(
//             label: 'Trash',
//             icon: Icon(Icons.delete_outline),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget build(BuildContext context) {
//   //   return CupertinoTabScaffold(
//   //     tabBar: CupertinoTabBar(items: const [
//   //       BottomNavigationBarItem(
//   //         label: 'Vault',
//   //         icon: Icon(Icons.lock_outline),
//   //       ),
//   //       BottomNavigationBarItem(
//   //         label: 'Generator',
//   //         icon: Icon(Icons.generating_tokens_outlined),
//   //       ),
//   //       BottomNavigationBarItem(
//   //         label: 'Trash',
//   //         icon: Icon(Icons.delete_outline),
//   //       ),
//   //     ]),
//   //     tabBuilder: (context, index) {
//   //       switch (index) {
//   //         case 0:
//   //           return CupertinoTabView(
//   //             builder: (context) {
//   //               return CupertinoPageScaffold(child: VaultPage());
//   //             },
//   //           );
//   //         case 1:
//   //           return CupertinoTabView(
//   //             builder: (context) {
//   //               return CupertinoPageScaffold(child: GeneratorPage());
//   //             },
//   //           );
//   //         case 2:
//   //           return CupertinoTabView(
//   //             builder: (context) {
//   //               return CupertinoPageScaffold(child: TrashPage());
//   //             },
//   //           );
//   //         default:
//   //           CupertinoTabView(
//   //             builder: (context) {
//   //               return CupertinoPageScaffold(child: VaultPage());
//   //             },
//   //           );
//   //       }
//   //       return Container();
//   //     },
// //       body: IndexedStack(
// //         index: currentIndex,
// //         children: screens,
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: currentIndex,
// //         type: BottomNavigationBarType.fixed,
// //         selectedItemColor: Theme.of(context).primaryColor,
// //         onTap: (value) {
// //           // Respond to item press.
// //           setState(() {
// //             currentIndex = value;
// //           });
// //         },
// //         items: const [
// //           BottomNavigationBarItem(
// //             label: 'Vault',
// //             icon: Icon(Icons.lock_outline),
// //           ),
// //           BottomNavigationBarItem(
// //             label: 'Generator',
// //             icon: Icon(Icons.generating_tokens_outlined),
// //           ),
// //           BottomNavigationBarItem(
// //             label: 'Trash',
// //             icon: Icon(Icons.delete_outline),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// }
