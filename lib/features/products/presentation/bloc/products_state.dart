part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const <Product>[],
    this.errorMessage = '',
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.nextOffset = 0,
  });

  final ProductsStatus status;
  final List<Product> products;
  final String errorMessage;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int nextOffset;

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    String? errorMessage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? nextOffset,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      nextOffset: nextOffset ?? this.nextOffset,
    );
  }

  @override
  List<Object> get props => [
    status,
    products,
    errorMessage,
    hasReachedMax,
    isLoadingMore,
    nextOffset,
  ];
}
