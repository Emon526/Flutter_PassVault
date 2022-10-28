import 'package:flutter/material.dart';

import 'generatorpage.dart';
import 'trashpage.dart';
import 'vaultpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const VaultPage(),
    const GeneratorPage(),
    const TrashPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (value) {
          // Respond to item press.
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Vault',
            icon: Icon(Icons.lock_outline),
          ),
          BottomNavigationBarItem(
            label: 'Generator',
            icon: Icon(Icons.generating_tokens_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Trash',
            icon: Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}
