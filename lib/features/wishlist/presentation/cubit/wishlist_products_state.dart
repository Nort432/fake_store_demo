part of 'wishlist_products_cubit.dart';

enum WishlistProductsStatus { initial, loading, success, failure }

class WishlistProductsState extends Equatable {
  const WishlistProductsState({
    this.status = WishlistProductsStatus.initial,
    this.products = const <Product>[],
    this.errorMessage = '',
  });

  final WishlistProductsStatus status;
  final List<Product> products;
  final String errorMessage;

  WishlistProductsState copyWith({
    WishlistProductsStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return WishlistProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
