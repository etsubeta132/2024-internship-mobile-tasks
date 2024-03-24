import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/product/domain/usecases/get_one_product.dart';

class DeleteProduct implements UseCase<String, Params>{
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure,String>> call(Params params) async {
    return await repository.deleteProduct(params.id);
  }
}
