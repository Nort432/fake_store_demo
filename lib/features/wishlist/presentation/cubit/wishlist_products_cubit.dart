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

  Future<void> syncWith(Set<int> ids) async {
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

    final retained = state.products
        .where((item) => ids.contains(item.id))
        .toList();
    final retainedIds = retained.map((item) => item.id).toSet();
    final missingIds = ids.where((id) => !retainedIds.contains(id)).toList()
      ..sort();

    if (retained.isNotEmpty) {
      emit(
        state.copyWith(
          status: WishlistProductsStatus.success,
          products: retained,
          errorMessage: '',
        ),
      );
    } else if (state.status != WishlistProductsStatus.loading) {
      emit(
        state.copyWith(
          status: WishlistProductsStatus.loading,
          errorMessage: '',
        ),
      );
    }

    if (missingIds.isEmpty) {
      return;
    }

    try {
      final fetched = await Future.wait(
        missingIds.map(_productsRepository.fetchProductById),
        eagerError: false,
      );
      final byId = <int, Product>{
        for (final item in retained) item.id: item,
        for (final item in fetched) item.id: item,
      };
      final ordered = ids.map((id) => byId[id]).whereType<Product>().toList();

      emit(
        state.copyWith(
          status: WishlistProductsStatus.success,
          products: ordered,
          errorMessage: '',
        ),
      );
    } on ProductsFailure catch (error) {
      if (retained.isNotEmpty) {
        emit(
          state.copyWith(
            status: WishlistProductsStatus.success,
            products: retained,
            errorMessage: error.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: WishlistProductsStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }

  Future<void> loadFor(Set<int> ids) async {
    await syncWith(ids);
  }
}
