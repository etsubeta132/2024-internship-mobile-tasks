import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/core/error/exceptions.dart';

import 'dart:convert';

abstract class ProductLocalDataSource {
  /// Gets the cached [ProductModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws a [NoLocalDataException] if no cached data is present.
  Future<List<ProductModel>> getLocalProducts();

  Future<void> cacheLocalProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLocalProducts() async {
    final jsonString = sharedPreferences.getString('CACHED_PRODUCT');
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString!);

      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw CacheException();
    }
  }

   @override
  Future<void> cacheLocalProducts(List<ProductModel> products) async {

    final List<Map<String, dynamic>> jsonList = products.map((product) => product.toJson()).toList();
    final jsonString = json.encode(jsonList);

    await sharedPreferences.setString('CACHED_PRODUCT', jsonString);
  }
}
