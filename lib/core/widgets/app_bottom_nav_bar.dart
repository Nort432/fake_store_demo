import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_typography.dart';

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
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
      decoration: BoxDecoration(
        color: context.appPalette.surfaceCard,
        border: Border(top: BorderSide(color: context.appPalette.borderSubtle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            tab: AppBottomTab.home,
            activeTab: activeTab,
            label: 'Home',
            icon: Icons.home_outlined,
            onTap: onTabSelected,
          ),
          _NavItem(
            tab: AppBottomTab.wishlist,
            activeTab: activeTab,
            label: 'Wishlist',
            icon: Icons.favorite_border,
            onTap: onTabSelected,
          ),
          _NavItem(
            tab: AppBottomTab.cart,
            activeTab: activeTab,
            label: 'Cart',
            icon: Icons.shopping_cart_outlined,
            onTap: onTabSelected,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.activeTab,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final AppBottomTab tab;
  final AppBottomTab activeTab;
  final String label;
  final IconData icon;
  final ValueChanged<AppBottomTab> onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = tab == activeTab;
    final color = isActive
        ? context.appPalette.navActive
        : context.appPalette.navInactive;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onTap(tab),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: context.appTypography.navLabel.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
