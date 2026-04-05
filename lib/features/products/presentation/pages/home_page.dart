import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/product_card.dart';
import '../bloc/products_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsBloc>()..add(const ProductsStarted()),
      child: _HomeView(username: username),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({this.username});

  final String? username;

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _scrollController = ScrollController();
  final Set<int> _favoriteProductIds = <int>{};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final threshold = _scrollController.position.maxScrollExtent - 200;
    if (_scrollController.position.pixels >= threshold) {
      context.read<ProductsBloc>().add(const ProductsLoadMoreRequested());
    }
  }

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
              _HomeHeader(
                username: widget.username,
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
                  child: Container(
                    color: Colors.transparent,
                    child: BlocBuilder<ProductsBloc, ProductsState>(
                      builder: (context, state) {
                        if (state.status == ProductsStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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

                        return ListView.separated(
                          controller: _scrollController,
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
                            final isFavorite = _favoriteProductIds.contains(
                              product.id,
                            );
                            return ProductCard(
                              imageUrl: product.imageUrl,
                              title: product.title,
                              subtitle: product.subtitle,
                              price: product.price,
                              rating: product.rating,
                              isFavorite: isFavorite,
                              onFavoriteTap: () => _toggleFavorite(product.id),
                              onTap: () =>
                                  context.push('/product/${product.id}'),
                            );
                          },
                        );
                      },
                    ),
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

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteProductIds.contains(productId)) {
        _favoriteProductIds.remove(productId);
      } else {
        _favoriteProductIds.add(productId);
      }
    });
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.username, required this.onLogout});

  final String? username;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final trimmedUsername = username?.trim() ?? '';
    final greeting = trimmedUsername.isEmpty
        ? 'Welcome'
        : 'Welcome, $trimmedUsername';

    return Row(
      children: [
        Expanded(
          child: Text(greeting, style: context.appTypography.headerGreeting),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onLogout,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.appPalette.buttonLightGold,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout,
                    size: 20,
                    color: context.appPalette.textHeader,
                  ),
                ),
                const SizedBox(height: 6),
                Text('Log out', style: context.appTypography.logoutLabel),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
