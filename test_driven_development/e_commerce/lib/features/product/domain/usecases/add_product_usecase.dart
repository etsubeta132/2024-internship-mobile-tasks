import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/core/usecases/usecase.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

class AddProductUseCase implements UseCase<ProductModel, AddParams> {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductModel>> call(AddParams params) async {
    return await repository.addProduct(params.product, params.imageFile);
  }
}

class AddParams extends Equatable {
  final ProductModel product;
  final File? imageFile;

  const AddParams({required this.product, this.imageFile});
  @override
  List<Object> get props => [id];
}
