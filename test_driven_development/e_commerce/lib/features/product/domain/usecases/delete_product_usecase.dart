import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteProductUseCase implements UseCase<String, DeleteParams>{
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure,String>> call(DeleteParams params) async {
    return await repository.deleteProduct(params.id);
  }
}

class DeleteParams extends Equatable {
  final String id;

  const DeleteParams({required this.id});
  @override
  List<Object> get props => [id];
}