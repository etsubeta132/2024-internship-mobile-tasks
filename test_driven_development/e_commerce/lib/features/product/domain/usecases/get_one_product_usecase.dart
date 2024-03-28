import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class GetOneProductUseCase implements UseCase<ProductModel, GetParams> {
  final ProductRepository repository;

  GetOneProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(GetParams params) async {
    return await repository.getOneProduct(params.id);
  }
}

class GetParams extends Equatable {
  final String id;

  const GetParams({required this.id});
  @override
  List<Object> get props => [id];
}
