import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wishlist_state.dart';

@lazySingleton
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit(this._preferences) : super(const WishlistState()) {
    _restore();
  }

  static const _storageKey = 'wishlist_product_ids';

  final SharedPreferences _preferences;

  bool contains(int productId) => state.productIds.contains(productId);

  Future<void> toggle(int productId) async {
    final next = <int>{...state.productIds};
    if (next.contains(productId)) {
      next.remove(productId);
    } else {
      next.add(productId);
    }
    emit(state.copyWith(productIds: next));
    await _save(next);
  }

  Future<void> _restore() async {
    final raw = _preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      emit(state.copyWith(isReady: true));
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        final ids = decoded
            .map((item) => int.tryParse(item.toString()))
            .whereType<int>()
            .toSet();
        emit(state.copyWith(productIds: ids, isReady: true));
        return;
      }
    } catch (_) {
      // Ignore malformed persistence data and start clean.
    }

    emit(state.copyWith(productIds: <int>{}, isReady: true));
  }

  Future<void> _save(Set<int> ids) {
    final value = jsonEncode(ids.toList()..sort());
    return _preferences.setString(_storageKey, value);
  }
}
