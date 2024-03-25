import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:uuid/uuid.dart';

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Either<Failure, ProductModel>> call({
    required String title,
    required String image,
    required double rating,
    required double price,
    required String category,
    required String description,
  }) async {
    // Create a new Product object with updated values
    final ProductModel  newProduct = ProductModel(
      id : const Uuid().v4(),
      title: title,
      image: image,
      rating: rating,
      price: price,
      category: category,
      description: description,
    );

    // Call the repository method to add the product
    return await repository.addProduct(newProduct);
  }
}
