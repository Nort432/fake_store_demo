import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/plant_background.png',
                height: 330,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 28),
              SvgPicture.asset('assets/icons/fake_store_logo.svg', height: 46),
              const SizedBox(height: 20),
              Text(
                'Fake Store',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Spacer(),
              AppButton(label: 'Login', onPressed: () => context.go('/login')),
            ],
          ),
        ),
      ),
    );
  }
}
