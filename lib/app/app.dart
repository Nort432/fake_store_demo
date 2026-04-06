import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/cubit/home_session_cubit.dart';
import '../features/cart/presentation/cubit/cart_cubit.dart';
import '../features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'router/app_router.dart';

class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>.value(value: getIt<CartCubit>()),
        BlocProvider<HomeSessionCubit>.value(
          value: getIt<HomeSessionCubit>()..restoreUserName(),
        ),
        BlocProvider<WishlistCubit>.value(value: getIt<WishlistCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Fake Store Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: getIt<AppRouter>().router,
      ),
    );
  }
}
