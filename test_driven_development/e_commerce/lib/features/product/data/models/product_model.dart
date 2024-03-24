import 'package:e_commerce/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String imageUrl,
    required double rating,
    required double price,
    required String name,
    required String category,
    required String description,
  }) : super(
            id: id,
            imageUrl: imageUrl,
            rating: rating,
            price: price,
            name: name,
            category: category,
            description: description);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final imageUrl = json['imageUrl'];
    final rating = double.tryParse(json['rating']) ?? 0.0;
    final price = double.tryParse(json['price']) ?? 0.0;
    final name = json['name'];
    final category = json['category'];
    final description = json['description'];

    return ProductModel(
      id:id,
      imageUrl: imageUrl,
      rating: rating,
      price: price,
      name: name,
      category: category,
      description: description,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "imageUrl": imageUrl,
      "rating": rating.toString(),
      "price": price.toString(),
      "name": name,
      "category": category,
      "description": description
    };
  }
}
