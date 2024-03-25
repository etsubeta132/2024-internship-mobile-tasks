import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';

abstract class ProductRepository {

  Future<Either<Failure,List<ProductModel>>> getProducts();

  Future<Either<Failure,ProductModel>> getOneProduct(String id);

  Future<Either<Failure,ProductModel>> addProduct(ProductModel product);

  Future<Either<Failure,ProductModel>> updateProduct(String id);
  
  Future<Either<Failure,String>> deleteProduct(String id);

}
