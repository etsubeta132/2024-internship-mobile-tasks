import 'dart:convert';

import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getProducts();

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> getOneProduct(String id);

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> addProduct(ProductModel product);

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProductModel> updateProduct(String id);

  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getOneProduct(String id) async {
    final Uri url =
        Uri.parse('https://products-api-5a5n.onrender.com/api/v1/products/$id');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final Uri url =
        Uri.parse('https://products-api-5a5n.onrender.com/api/v1/products');
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> productsJson = responseData['products'];
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final Uri url =
        Uri.parse('https://products-api-5a5n.onrender.com/api/v1/products');
    final response = await client.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()));
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deleteProduct(String id) async {
    final Uri url =
        Uri.parse('https://products-api-5a5n.onrender.com/api/v1/products/$id');
    final response = await client.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(String id) async {
    final Uri url =
        Uri.parse('https://products-api-5a5n.onrender.com/api/v1/products/$id');
    final response = await client.patch(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
