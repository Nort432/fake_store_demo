part of 'cart_cubit.dart';

class CartItem extends Equatable {
  const CartItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final int quantity;

  double get total => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, price, quantity];
}

class CartState extends Equatable {
  const CartState({this.items = const <CartItem>[]});

  final List<CartItem> items;

  bool get isEmpty => items.isEmpty;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
