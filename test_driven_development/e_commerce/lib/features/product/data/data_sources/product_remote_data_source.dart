

import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource{
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
    Future<ProductModel> addProduct(Product product);


  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
    Future<ProductModel> updateProduct(String id);
  
  /// Calls the http://.. endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
    Future<String> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource{
  @override
  Future<ProductModel> addProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<String> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getOneProduct(String id) {
    // TODO: implement getOneProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> updateProduct(String id) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
  
}