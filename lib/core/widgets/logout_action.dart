import 'package:flutter/material.dart';

class LogoutAction extends StatelessWidget {
  const LogoutAction({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
    );
  }
}
