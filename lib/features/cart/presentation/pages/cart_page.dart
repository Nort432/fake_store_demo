import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_button.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_page/cart_empty_section.dart';
import '../widgets/cart_page/cart_item_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appPalette.surfaceCard,
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return CartEmptySection(
              onContinueShopping: () => context.go('/home'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return CartItemTile(item: item);
                  },
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.appPalette.surfaceCard,
                  border: Border(
                    top: BorderSide(color: context.appPalette.borderSubtle),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items: ${state.totalItems}',
                          style: context.appTypography.productMeta,
                        ),
                        Text(
                          '\$${state.totalPrice.toStringAsFixed(2)}',
                          style: context.appTypography.priceAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      label: 'Checkout',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Checkout is out of scope for this task',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        activeTab: AppBottomTab.cart,
        onTabSelected: (tab) {
          switch (tab) {
            case AppBottomTab.home:
              context.go('/home');
            case AppBottomTab.cart:
              context.go('/cart');
            case AppBottomTab.wishlist:
              context.go('/wishlist');
          }
        },
      ),
    );
  }
}
