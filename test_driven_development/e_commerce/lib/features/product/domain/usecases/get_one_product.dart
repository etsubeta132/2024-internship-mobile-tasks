import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class GetOneProduct implements UseCase<Product, Params> {
  final ProductRepository repository;

  GetOneProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(Params params) async {
    return await repository.getOneProduct(params.id);
  }
}

class Params extends Equatable {
  final String id;
  const Params({required this.id});
  @override
  List<Object> get props => [id];
}
