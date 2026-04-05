import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/repositories/products_repository.dart';
import '../cubit/product_details_cubit.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({required this.productId, super.key});

  final String productId;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductDetailsCubit _cubit;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _cubit = ProductDetailsCubit(getIt<ProductsRepository>());
    final id = int.tryParse(widget.productId);
    if (id == null) {
      _cubit.setInvalidId();
    } else {
      _cubit.loadById(id);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: context.appPalette.surfaceCard,
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state.status == ProductDetailsStatus.loading ||
                state.status == ProductDetailsStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ProductDetailsStatus.failure ||
                state.product == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.errorMessage.isEmpty
                            ? 'Failed to load product'
                            : state.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: () {
                          final id = int.tryParse(widget.productId);
                          if (id != null) {
                            context.read<ProductDetailsCubit>().loadById(id);
                          }
                        },
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final product = state.product!;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: context.appPalette.surfaceBase,
                    child: Stack(
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (context.canPop()) {
                                      context.pop();
                                    } else {
                                      context.go('/home');
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    setState(() => _isFavorite = !_isFavorite);
                                  },
                                  icon: Icon(
                                    _isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _isFavorite
                                        ? context.appPalette.heartActive
                                        : context.appPalette.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                            child: product.imageUrl.isEmpty
                                ? const Icon(Icons.image_not_supported_outlined)
                                : Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.broken_image_outlined,
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: context.appPalette.surfaceCard,
                  constraints: const BoxConstraints(minHeight: 158),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: context.appTypography.screenTitle,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.subtitle,
                            style: context.appTypography.productSubtitle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: context.appPalette.textPrimary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toStringAsFixed(2),
                            style: context.appTypography.productMeta,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '12 Reviews',
                            style: context.appTypography.productSubtitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: context.appPalette.accentPale,
                  child: SafeArea(
                    top: false,
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 96),
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Price',
                                style: context.appTypography.productSubtitle,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: context.appTypography.priceAccent,
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      context.appPalette.buttonDark,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Cart flow will be implemented next',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Add to cart'),
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
    );
  }
}
