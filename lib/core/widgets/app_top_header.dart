import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_typography.dart';

class AppTopHeader extends StatelessWidget {
  const AppTopHeader({required this.title, required this.onLogout, super.key});

  final String title;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: context.appTypography.headerGreeting),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onLogout,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.appPalette.buttonLightGold,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout,
                    size: 20,
                    color: context.appPalette.textHeader,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Log out', style: context.appTypography.logoutLabel),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
