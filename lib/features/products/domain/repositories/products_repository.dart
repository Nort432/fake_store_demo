import '../entities/product.dart';

abstract interface class ProductsRepository {
  Future<List<Product>> fetchProducts({
    required int offset,
    required int limit,
  });
}

class ProductsFailure implements Exception {
  const ProductsFailure(this.message);

  final String message;
}
