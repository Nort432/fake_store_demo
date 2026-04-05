import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/product_dto.dart';

@lazySingleton
class ProductsRemoteDataSource {
  const ProductsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ProductDto>> fetchProducts({
    required int offset,
    required int limit,
  }) async {
    final response = await _dio.get<List<dynamic>>(
      '/products',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    final data = response.data ?? <dynamic>[];
    return data
        .whereType<Map<String, dynamic>>()
        .map(ProductDto.fromJson)
        .toList();
  }

  Future<ProductDto> fetchProductById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/products/$id');
    final data = response.data ?? <String, dynamic>{};
    return ProductDto.fromJson(data);
  }
}
