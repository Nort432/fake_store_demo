part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  const WishlistState({this.productIds = const <int>{}, this.isReady = false});

  final Set<int> productIds;
  final bool isReady;

  WishlistState copyWith({Set<int>? productIds, bool? isReady}) {
    return WishlistState(
      productIds: productIds ?? this.productIds,
      isReady: isReady ?? this.isReady,
    );
  }

  @override
  List<Object?> get props => [productIds, isReady];
}
