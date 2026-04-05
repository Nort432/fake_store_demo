import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_palette.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../../core/widgets/product_card.dart';
import '../../../../wishlist/presentation/cubit/wishlist_cubit.dart';
import '../../bloc/products_bloc.dart';
import 'home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({required this.username, super.key});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appPalette.surfaceCard,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                username: username,
                onLogout: () => context.go('/welcome'),
              ),
              const SizedBox(height: 18),
              Text('Fake Store', style: context.appTypography.screenTitle),
              const SizedBox(height: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state.status == ProductsStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.status == ProductsStatus.failure &&
                          state.products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(state.errorMessage),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ProductsBloc>().add(
                                    const ProductsStarted(),
                                  );
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        );
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent - 200) {
                            context.read<ProductsBloc>().add(
                              const ProductsLoadMoreRequested(),
                            );
                          }
                          return false;
                        },
                        child: ListView.separated(
                          itemCount:
                              state.products.length +
                              (state.isLoadingMore ? 1 : 0),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            if (index >= state.products.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final product = state.products[index];
                            final isFavorite = context
                                .watch<WishlistCubit>()
                                .contains(product.id);
                            return ProductCard(
                              imageUrl: product.imageUrl,
                              title: product.title,
                              subtitle: product.subtitle,
                              price: product.price,
                              rating: product.rating,
                              isFavorite: isFavorite,
                              onFavoriteTap: () => context
                                  .read<WishlistCubit>()
                                  .toggle(product.id),
                              onTap: () =>
                                  context.push('/product/${product.id}'),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        activeTab: AppBottomTab.home,
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
