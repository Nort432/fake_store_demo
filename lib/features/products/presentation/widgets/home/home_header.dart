import 'package:flutter/material.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.username, required this.onLogout, super.key});

  final String? username;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final trimmedUsername = username?.trim() ?? '';
    final greeting = trimmedUsername.isEmpty
        ? 'Welcome'
        : 'Welcome, $trimmedUsername';

    return Row(
      children: [
        Expanded(
          child: Text(greeting, style: context.appTypography.headerGreeting),
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
