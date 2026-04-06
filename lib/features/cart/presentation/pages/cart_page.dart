import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_bottom_nav_router.dart';
import '../../../../core/widgets/app_top_header.dart';
import '../../../auth/presentation/cubit/home_session_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/cart_page/cart_empty_section.dart';
import '../widgets/cart_page/cart_item_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeSessionCubit, HomeSessionState>(
      listenWhen: (previous, current) =>
          previous.didLogout != current.didLogout,
      listener: (context, state) {
        if (state.didLogout) {
          context.read<HomeSessionCubit>().resetLogoutFlag();
          context.go('/welcome');
        }
      },
      child: Scaffold(
        backgroundColor: context.appPalette.surfaceCard,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
            child: Column(
              children: [
                AppTopHeader(
                  title: 'Cart',
                  onLogout: () => context.read<HomeSessionCubit>().logout(),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: BlocBuilder<CartCubit, CartState>(
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                top: BorderSide(
                                  color: context.appPalette.borderSubtle,
                                ),
                              ),
                            ),
                            child: SafeArea(
                              top: false,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  14,
                                  24,
                                  14,
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Cart total',
                                          style:
                                              context.appTypography.productMeta,
                                        ),
                                        Text(
                                          '\$${state.totalPrice.toStringAsFixed(2)}',
                                          style:
                                              context.appTypography.priceAccent,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: SizedBox(
                                        height: 48,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                context.appPalette.buttonDark,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Checkout is out of scope for this task',
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Checkout'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppBottomNavBar(
          activeTab: AppBottomTab.cart,
          onTabSelected: context.goByBottomTab,
        ),
      ),
    );
  }
}
