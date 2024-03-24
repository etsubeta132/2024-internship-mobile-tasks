import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failures.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:uuid/uuid.dart';

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Either<Failure, Product>> call({
    required String name,
    required String imageUrl,
    required double rating,
    required double price,
    required String category,
    required String description,
  }) async {
    // Create a new Product object with updated values
    final Product  newProduct = Product(
      id : const Uuid().v4(),
      name: name,
      imageUrl: imageUrl,
      rating: rating,
      price: price,
      category: category,
      description: description,
    );

    // Call the repository method to add the product
    return await repository.addProduct(newProduct);
  }
}
