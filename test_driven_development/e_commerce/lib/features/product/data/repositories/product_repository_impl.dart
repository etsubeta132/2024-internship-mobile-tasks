import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:e_commerce/features/product/data/data_sources/product_local_data_source.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';

import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

import '../../../../core/network/network_info.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSorce;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSorce,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> getOneProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getOneProduct(id);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        localDataSorce.cacheLocalProducts (remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSorce.getLocalProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.addProduct(product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return Right(id);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.updateProduct(id);
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }



// Future<Either<Failure, Product>> _CallProductMethods () async {
  
//     if (await networkInfo.isConnected) {
//       try {
//         final product = await remoteDataSource.updateProduct(id);
//         return Right(product);
//       } on ServerException {
//         return Left(ServerFailure());
//       }
//     } else {
//       return Left(ServerFailure());
//     }
//   }


}
