import 'package:dio/dio.dart';
import 'package:itecotesttask/models/product/product.dart';

class ProductsRepository {
  ProductsRepository({required this.dio});

  final Dio dio;
  final String _baseUrl = 'https://fakestoreapi.com';

  String get _fetchProducts => '$_baseUrl/products';

  Future<List<Product>> fetchProducts() async {
    final Response<dynamic> response = await dio.get(_fetchProducts);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Error');
    }
  }
}