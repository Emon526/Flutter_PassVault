import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  late final PageController _pageController =
      PageController(initialPage: _selectedIndex);
  PageController get pageController => _pageController;

  final List<String> _pages = ['Vault', 'Generator', 'Settings'];
  List<String> get pages => _pages;
  final List<IconData> _icons = [
    Icons.lock_outline,
    Icons.generating_tokens_outlined,
    Icons.settings_outlined
  ];
  List<IconData> get icons => _icons;

  set selectedIndex(int selected) {
    _selectedIndex = selected;
    _pageController.animateToPage(
      _selectedIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
    notifyListeners();
  }
}
