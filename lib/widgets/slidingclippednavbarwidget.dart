import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class SlidingClippedNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;
  final List<IconData> navBarIcon;
  final List<String> navBarTitle;
  const SlidingClippedNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.navBarIcon,
    required this.navBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SlidingClippedNavBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      activeColor: Theme.of(context).iconTheme.color!,
      inactiveColor: Colors.grey.shade600,
      selectedIndex: selectedIndex,
      barItems: [
        for (int i = 0; i < navBarIcon.length; i++)
          BarItem(
            icon: navBarIcon[i],
            title: navBarTitle[i],
          ),
      ],
      onButtonPressed: onItemSelected,
    );
  }
}
