import 'package:fake_store_demo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:fake_store_demo/features/products/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartCubit', () {
    late CartCubit cubit;

    setUp(() {
      cubit = CartCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('adds product and increments quantity for same product', () {
      const product = Product(
        id: 10,
        title: 'Demo product',
        description: 'desc',
        subtitle: 'Category',
        price: 19.99,
        imageUrl: '',
        rating: 4.5,
      );

      cubit.addProduct(product);
      cubit.addProduct(product);

      expect(cubit.state.items.length, 1);
      expect(cubit.state.items.first.quantity, 2);
      expect(cubit.state.totalItems, 2);
      expect(cubit.state.totalPrice, closeTo(39.98, 0.001));
    });

    test('decrement removes item when quantity reaches zero', () {
      const product = Product(
        id: 42,
        title: 'Another',
        description: 'desc',
        subtitle: 'Category',
        price: 10,
        imageUrl: '',
        rating: 4.1,
      );

      cubit.addProduct(product);
      cubit.decrement(product.id);

      expect(cubit.state.items, isEmpty);
      expect(cubit.state.totalItems, 0);
      expect(cubit.state.totalPrice, 0);
    });
  });
}
