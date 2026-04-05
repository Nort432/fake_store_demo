import 'package:flutter/material.dart';

enum AppBottomTab { home, cart, wishlist }

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.activeTab,
    required this.onTabSelected,
    super.key,
  });

  final AppBottomTab activeTab;
  final ValueChanged<AppBottomTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppBottomTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppBottomTab.values[index]),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Wishlist',
        ),
      ],
    );
  }
}
