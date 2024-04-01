import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class FetchProductsUseCase implements UseCase<List<ProductModel>, SearchParams> {
  final ProductRepository repository;

  FetchProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductModel>>> call(SearchParams params) async {
    return await repository.fetchProducts(params.searchQuery);
  }
}

class SearchParams extends Equatable {
  final String searchQuery;

  const SearchParams({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}
