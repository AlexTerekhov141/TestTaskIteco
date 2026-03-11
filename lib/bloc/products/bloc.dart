import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itecotesttask/repository/products_repository.dart';

import '../../models/product/product.dart';
import 'event.dart';
import 'state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this.repository) : super(ProductsState()){
    on<FetchProducts>(_onFetchProducts);
  }
  final ProductsRepository repository;

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductsState> emit) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      final List<Product> response = await repository.fetchProducts();
      emit(state.copyWith(
        isLoading: false,
          products: [
            ...state.products,
            ...response
          ]
      ));
    } catch (e){
      emit(state.copyWith(
        isLoading: false,
        error: e.toString()
      ));
    }
  }
}
