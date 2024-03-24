import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';

abstract class ProductRepository {

  Future<Either<Failure,List<Product>>> getProducts();

  Future<Either<Failure,Product>> getOneProduct(String id);

  Future<Either<Failure,Product>> addProduct(Product product);

  Future<Either<Failure,Product>> updateProduct(String id);
  
  Future<Either<Failure,String>> deleteProduct(String id);

}
