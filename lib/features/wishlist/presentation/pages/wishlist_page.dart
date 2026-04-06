import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_bottom_nav_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/product_card.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/wishlist_products_cubit.dart';
import '../widgets/wishlist/wishlist_empty_section.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<WishlistProductsCubit>();
        final wishlistState = context.read<WishlistCubit>().state;
        if (wishlistState.isReady) {
          cubit.loadFor(wishlistState.productIds);
        }
        return cubit;
      },
      child: const _WishlistView(),
    );
  }
}

class _WishlistView extends StatelessWidget {
  const _WishlistView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WishlistCubit, WishlistState>(
      listenWhen: (previous, current) =>
          previous.productIds != current.productIds ||
          previous.isReady != current.isReady,
      listener: (context, state) {
        if (state.isReady) {
          context.read<WishlistProductsCubit>().loadFor(state.productIds);
        }
      },
      child: Scaffold(
        backgroundColor: context.appPalette.surfaceCard,
        appBar: AppBar(title: const Text('Wishlist')),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, wishlistState) {
            if (!wishlistState.isReady) {
              return const Center(child: CircularProgressIndicator());
            }

            if (wishlistState.productIds.isEmpty) {
              return WishlistEmptySection(onGoHome: () => context.go('/home'));
            }

            return BlocBuilder<WishlistProductsCubit, WishlistProductsState>(
              builder: (context, productsState) {
                if (productsState.status == WishlistProductsStatus.initial ||
                    productsState.status == WishlistProductsStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (productsState.status == WishlistProductsStatus.failure) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            productsState.errorMessage.isEmpty
                                ? 'Failed to load wishlist items'
                                : productsState.errorMessage,
                          ),
                          const SizedBox(height: 12),
                          AppButton(
                            label: 'Try again',
                            onPressed: () {
                              context.read<WishlistProductsCubit>().loadFor(
                                wishlistState.productIds,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (productsState.products.isEmpty) {
                  return WishlistEmptySection(
                    onGoHome: () => context.go('/home'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                  itemCount: productsState.products.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = productsState.products[index];
                    return ProductCard(
                      imageUrl: product.imageUrl,
                      title: product.title,
                      subtitle: product.subtitle,
                      price: product.price,
                      rating: product.rating,
                      isFavorite: true,
                      onFavoriteTap: () =>
                          context.read<WishlistCubit>().toggle(product.id),
                      onTap: () => context.push('/product/${product.id}'),
                    );
                  },
                );
              },
            );
          },
        ),
        bottomNavigationBar: AppBottomNavBar(
          activeTab: AppBottomTab.wishlist,
          onTabSelected: context.goByBottomTab,
        ),
      ),
    );
  }
}
