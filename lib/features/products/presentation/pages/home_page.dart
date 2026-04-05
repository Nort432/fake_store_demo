import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../../core/widgets/logout_action.dart';
import '../../../../core/widgets/product_card.dart';
import '../bloc/products_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsBloc>()..add(const ProductsStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _scrollController = ScrollController();

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
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hello, Shopper',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  LogoutAction(onTap: () => context.go('/welcome')),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
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

                    return ListView.separated(
                      controller: _scrollController,
                      itemCount:
                          state.products.length + (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (index >= state.products.length) {
                          if (state.hasReachedMax) {
                            return const SizedBox.shrink();
                          }
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final product = state.products[index];
                        return ProductCard(
                          imageUrl: product.imageUrl,
                          title: product.title,
                          price: product.price,
                          rating: product.rating,
                          onTap: () => context.push('/product/${product.id}'),
                        );
                      },
                    );
                  },
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
