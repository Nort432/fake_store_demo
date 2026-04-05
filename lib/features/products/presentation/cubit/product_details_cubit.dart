import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';

part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._productsRepository)
    : super(const ProductDetailsState());

  final ProductsRepository _productsRepository;

  void setInvalidId() {
    emit(
      const ProductDetailsState(
        status: ProductDetailsStatus.failure,
        errorMessage: 'Invalid product id',
      ),
    );
  }

  Future<void> loadById(int productId) async {
    emit(
      state.copyWith(status: ProductDetailsStatus.loading, errorMessage: ''),
    );

    try {
      final product = await _productsRepository.fetchProductById(productId);
      emit(
        state.copyWith(status: ProductDetailsStatus.success, product: product),
      );
    } on ProductsFailure catch (error) {
      emit(
        state.copyWith(
          status: ProductDetailsStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }
}
