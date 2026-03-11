import 'package:itecotesttask/models/product/product.dart';
import 'package:equatable/equatable.dart';

class ProductsState extends Equatable{

  const ProductsState({
    this.isLoading = false,
    this.products = const <Product>[],
    this.error,
  });

  final bool isLoading;
  final List<Product> products;
  final String? error;

  ProductsState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? error,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[isLoading, products, error];
}
