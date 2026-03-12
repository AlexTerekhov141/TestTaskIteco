import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:itecotesttask/repository/products_repository.dart';

import '../../models/product/product.dart';
import 'event.dart';
import 'state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this.repository) : super(ProductsState()){
    on<FetchProducts>(_onFetchProducts);
    on<FetchMoreProducts>(_onFetchMoreProducts);
  }
  final ProductsRepository repository;

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductsState> emit) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      final List<Product> response = await repository.fetchProducts();
      emit(state.copyWith(
        isLoading: false,
        products: response
      ));
    } catch (e){
      emit(state.copyWith(
        isLoading: false,
        error: e.toString()
      ));
    }
  }

  Future<void> _onFetchMoreProducts(FetchMoreProducts event, Emitter<ProductsState> emit) async {
    if (state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));

    try {
      emit(state.copyWith(
        isLoadingMore: false,
        products: [
          ...state.products,
          ...state.products
        ]
      ));
    } catch (e){
      emit(state.copyWith(
        isLoadingMore: false,
        error: e.toString()
      ));
    }
  }
}
