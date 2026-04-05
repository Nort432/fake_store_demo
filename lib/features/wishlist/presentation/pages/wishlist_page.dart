import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/domain/repositories/products_repository.dart';
import '../cubit/wishlist_cubit.dart';
import '../widgets/wishlist/wishlist_empty_section.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _productsRepository = getIt<ProductsRepository>();

  Future<List<Product>> _loadProducts(Set<int> ids) async {
    final sortedIds = ids.toList()..sort();
    final results = await Future.wait(
      sortedIds.map((id) => _productsRepository.fetchProductById(id)),
      eagerError: false,
    );
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appPalette.surfaceCard,
      appBar: AppBar(title: const Text('Wishlist')),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (!state.isReady) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.productIds.isEmpty) {
            return WishlistEmptySection(onGoHome: () => context.go('/home'));
          }

          return FutureBuilder<List<Product>>(
            future: _loadProducts(state.productIds),
            builder: (context, snapshot) {
              if (!snapshot.hasData && !snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Failed to load wishlist items'),
                        const SizedBox(height: 12),
                        AppButton(
                          label: 'Try again',
                          onPressed: () => setState(() {}),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final products = snapshot.data ?? const <Product>[];
              if (products.isEmpty) {
                return WishlistEmptySection(
                  onGoHome: () => context.go('/home'),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final product = products[index];
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
