part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsStarted extends ProductsEvent {
  const ProductsStarted();
}

class ProductsLoadMoreRequested extends ProductsEvent {
  const ProductsLoadMoreRequested();
}
