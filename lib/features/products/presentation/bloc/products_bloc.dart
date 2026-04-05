import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this._productsRepository) : super(const ProductsState()) {
    on<ProductsStarted>(_onStarted);
    on<ProductsLoadMoreRequested>(_onLoadMoreRequested);
  }

  static const int _pageLimit = 10;
  final ProductsRepository _productsRepository;

  Future<void> _onStarted(
    ProductsStarted event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading, errorMessage: ''));

    try {
      final products = await _productsRepository.fetchProducts(
        offset: 0,
        limit: _pageLimit,
      );

      emit(
        state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: products.length < _pageLimit,
          nextOffset: products.length,
        ),
      );
    } on ProductsFailure catch (error) {
      emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }

  Future<void> _onLoadMoreRequested(
    ProductsLoadMoreRequested event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.status != ProductsStatus.success ||
        state.hasReachedMax ||
        state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    try {
      final products = await _productsRepository.fetchProducts(
        offset: state.nextOffset,
        limit: _pageLimit,
      );

      emit(
        state.copyWith(
          products: [...state.products, ...products],
          isLoadingMore: false,
          hasReachedMax: products.length < _pageLimit,
          nextOffset: state.nextOffset + products.length,
        ),
      );
    } on ProductsFailure catch (error) {
      emit(state.copyWith(isLoadingMore: false, errorMessage: error.message));
    }
  }
}
