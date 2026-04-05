import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_typography.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/plant_background.png', fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  SvgPicture.asset(
                    'assets/icons/fake_store_logo.svg',
                    width: 58,
                    height: 58,
                  ),
                  const SizedBox(height: 17),
                  Text('Fake Store', style: context.appTypography.screenTitle),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => context.push('/login'),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
