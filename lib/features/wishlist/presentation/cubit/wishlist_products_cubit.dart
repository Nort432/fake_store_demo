import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../products/domain/entities/product.dart';
import '../../../products/domain/repositories/products_repository.dart';

part 'wishlist_products_state.dart';

@injectable
class WishlistProductsCubit extends Cubit<WishlistProductsState> {
  WishlistProductsCubit(this._productsRepository)
    : super(const WishlistProductsState());

  final ProductsRepository _productsRepository;

  Future<void> loadFor(Set<int> ids) async {
    if (ids.isEmpty) {
      emit(
        state.copyWith(
          status: WishlistProductsStatus.success,
          products: const <Product>[],
          errorMessage: '',
        ),
      );
      return;
    }

    emit(
      state.copyWith(status: WishlistProductsStatus.loading, errorMessage: ''),
    );

    try {
      final sortedIds = ids.toList()..sort();
      final products = await Future.wait(
        sortedIds.map(_productsRepository.fetchProductById),
        eagerError: false,
      );

      emit(
        state.copyWith(
          status: WishlistProductsStatus.success,
          products: products,
          errorMessage: '',
        ),
      );
    } on ProductsFailure catch (error) {
      emit(
        state.copyWith(
          status: WishlistProductsStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }
}
