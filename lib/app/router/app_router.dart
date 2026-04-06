import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/products/presentation/pages/home_page.dart';
import '../../features/products/presentation/pages/product_page.dart';
import '../../features/wishlist/presentation/pages/wishlist_page.dart';

@lazySingleton
class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/welcome',
    routes: <RouteBase>[
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomePage()),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ProductPage(productId: id);
        },
      ),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: CartPage()),
      ),
      GoRoute(
        path: '/wishlist',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: WishlistPage()),
      ),
    ],
  );

  GoRouter get router => _router;
}
