import 'package:e_commerce/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String image,
    required double rating,
    required double price,
    required String title,
    required String category,
    required String description,
  }) : super(
            id: id,
            title: title,
            image: image,
            rating: rating,
            price: price,
            category: category,
            description: description);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
 
    return ProductModel(
      id: json['_id'],
      image: json['image'],
      rating: json['rating']['rate'],
      price: json['price'],
      title: json['title'],
      category: json['category'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "image": image,
      "rating": {'rate': rating, 'count': 0},
      "price": price,
      "category": category,
      "description": description
    };
  }
}
