import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateProductUseCase implements UseCase<ProductModel, UpdateParams> {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(UpdateParams params) async {
    return await repository.updateProduct(params.product, params.id,params.imageFile);
  }
}

class UpdateParams extends Equatable {
  final String id;
  final ProductModel product;
  final File? imageFile;

  UpdateParams({required this.id, required this.product,this.imageFile});

  @override
  List<Object> get props => [id];
}
