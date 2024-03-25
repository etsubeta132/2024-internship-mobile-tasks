import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

class UpdateProduct implements UseCase<ProductModel, Params> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

   Future<Either<Failure,String>> call(Params params) async {
    return await repository.updateProduct(params.id);
  }
}

