import 'package:injectable/injectable.dart';

import '../../../../core/network/network_error_mapper.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_data_source.dart';

@LazySingleton(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl(this._remoteDataSource, this._errorMapper);

  final ProductsRemoteDataSource _remoteDataSource;
  final NetworkErrorMapper _errorMapper;

  @override
  Future<List<Product>> fetchProducts({
    required int offset,
    required int limit,
  }) async {
    try {
      final items = await _remoteDataSource.fetchProducts(
        offset: offset,
        limit: limit,
      );

      return items.map((item) => item.toEntity()).toList();
    } catch (error) {
      throw ProductsFailure(_errorMapper.toMessage(error));
    }
  }

  @override
  Future<Product> fetchProductById(int id) async {
    try {
      final item = await _remoteDataSource.fetchProductById(id);
      return item.toEntity();
    } catch (error) {
      throw ProductsFailure(_errorMapper.toMessage(error));
    }
  }
}
