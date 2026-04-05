import 'package:flutter/material.dart';

import '../core/di/injection.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fake Store Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: getIt<AppRouter>().router,
    );
  }
}
