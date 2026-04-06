import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_bottom_nav_bar.dart';

extension AppBottomNavRoutingX on BuildContext {
  void goByBottomTab(AppBottomTab tab) {
    switch (tab) {
      case AppBottomTab.home:
        go('/home');
      case AppBottomTab.cart:
        go('/cart');
      case AppBottomTab.wishlist:
        go('/wishlist');
    }
  }
}
