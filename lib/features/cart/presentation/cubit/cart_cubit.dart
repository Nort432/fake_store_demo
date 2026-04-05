import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../products/domain/entities/product.dart';

part 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(Product product) {
    final existingIndex = state.items.indexWhere(
      (item) => item.id == product.id,
    );
    if (existingIndex >= 0) {
      final updated = [...state.items];
      final current = updated[existingIndex];
      updated[existingIndex] = current.copyWith(quantity: current.quantity + 1);
      emit(state.copyWith(items: updated));
      return;
    }

    emit(
      state.copyWith(
        items: [
          ...state.items,
          CartItem(
            id: product.id,
            title: product.title,
            subtitle: product.subtitle,
            imageUrl: product.imageUrl,
            price: product.price,
            quantity: 1,
          ),
        ],
      ),
    );
  }

  void increment(int productId) {
    final index = state.items.indexWhere((item) => item.id == productId);
    if (index < 0) return;

    final updated = [...state.items];
    final current = updated[index];
    updated[index] = current.copyWith(quantity: current.quantity + 1);
    emit(state.copyWith(items: updated));
  }

  void decrement(int productId) {
    final index = state.items.indexWhere((item) => item.id == productId);
    if (index < 0) return;

    final updated = [...state.items];
    final current = updated[index];
    if (current.quantity <= 1) {
      updated.removeAt(index);
    } else {
      updated[index] = current.copyWith(quantity: current.quantity - 1);
    }
    emit(state.copyWith(items: updated));
  }

  void remove(int productId) {
    emit(
      state.copyWith(
        items: state.items.where((item) => item.id != productId).toList(),
      ),
    );
  }

  void clear() => emit(const CartState());
}
