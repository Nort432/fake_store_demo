import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_palette.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../domain/repositories/products_repository.dart';
import '../cubit/product_details_cubit.dart';
import '../widgets/product_page/product_content_section.dart';
import '../widgets/product_page/product_error_section.dart';

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

  void _handleBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/home');
    }
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
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
              return ProductErrorSection(
                message: state.errorMessage,
                onRetry: () {
                  final id = int.tryParse(widget.productId);
                  if (id != null) {
                    context.read<ProductDetailsCubit>().loadById(id);
                  }
                },
              );
            }

            return ProductContentSection(
              product: state.product!,
              isFavorite: _isFavorite,
              onBack: () => _handleBack(context),
              onFavoriteTap: _toggleFavorite,
              onAddToCart: () {
                context.read<CartCubit>().addProduct(state.product!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added to cart')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
